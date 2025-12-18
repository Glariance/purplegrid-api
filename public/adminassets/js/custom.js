$(function () {
    console.log("Layout page loaded");

    // Attach CSRF token to all AJAX requests
    const csrf = $('meta[name="csrf-token"]').attr('content');
    if (csrf) {
        $.ajaxSetup({
            headers: { 'X-CSRF-TOKEN': csrf }
        });
    }

    // Ajax Post Request with Form Data
    window.ajaxPost = function (formSelector, btnSelector, successCallback, errorCallback) {
        $(document).on("submit", formSelector, function (e) {
            e.preventDefault();
            let form = $(this);
            let formData = new FormData(this);
            let actionUrl = form.attr("action");
            let files = (typeof getSelectedFile === 'function') ? getSelectedFile() : null; // Get file(s) from Dropzone
            const dropzoneArrayField = form.data('dropzoneArrayField') || 'file[]';
            const dropzoneSingleField = form.data('dropzoneSingleField') || 'file';
            
            // Get CSRF token from form's hidden input (created by @csrf)
            // This is the most reliable source as it's tied to the current session
            let csrf = form.find('input[name="_token"]').val();
            
            // Fallback to meta tag if form input not found
            if (!csrf) {
                csrf = $('meta[name="csrf-token"]').attr('content');
            }
            
            if (!csrf) {
                console.error('CSRF token not found! Check if @csrf is in the form and meta tag exists.');
                errorMessage('CSRF token missing. Please refresh the page and try again.');
                return false;
            }
            
            // CRITICAL: Always use the token from the form's hidden input
            // FormData should already have it, but we'll ensure it's set correctly
            formData.set('_token', csrf);
            
            // Debug: Log what we're sending
            console.log('CSRF Token being sent:', csrf.substring(0, 15) + '...');
            console.log('FormData _token value:', formData.get('_token') ? formData.get('_token').substring(0, 15) + '...' : 'MISSING');
            if (files) {
                if (Array.isArray(files)) {
                    files.forEach((f, i) => {
                        formData.append(dropzoneArrayField, f);
                    });
                } else {
                    formData.append(dropzoneSingleField, files);
                }
            }
            // Log cookies being sent (for debugging)
            console.log('Cookies:', document.cookie);
            
            $.ajax({
                url: actionUrl,
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                xhrFields: {
                    withCredentials: true
                },
                headers: {
                    'X-CSRF-TOKEN': csrf || $('meta[name="csrf-token"]').attr('content'),
                    'X-Requested-With': 'XMLHttpRequest'
                },
                beforeSend: function (xhr) {
                    // Ensure cookies are sent
                    xhr.withCredentials = true;
                    progressLoad();
                    // form.find("button[type=submit]").prop("disabled", true);
                    $(btnSelector).prop("disabled", true);
                },
                success: function (response) {
                    // successMessage(response.success)
                    if (successCallback) successCallback(response);
                },
                error: function (xhr) {
                    if (errorCallback) errorCallback(xhr);
                    let messageError = "Something went wrong!";
                    if (xhr.responseJSON) {
                        console.log(xhr.responseJSON);
                        let errors = xhr.responseJSON?.message ? xhr.responseJSON?.message : xhr.responseJSON.errors;

                        if (typeof errors === "object") {
                            Object.values(errors).forEach(msg => errorMessage(msg));
                        } else if (typeof errors === "string") {
                            errorMessage(errors);
                        } else {
                            errorMessage(messageError);
                        }
                    } else if (xhr.responseText) {
                        errorMessage(xhr.responseText);
                    } else {
                        errorMessage(messageError);
                    }
                },
                complete: function () {
                    Swal.close();
                    $(btnSelector).prop("disabled", false);
                    // form.find("button[type=submit]").prop("disabled", false);
                }
            });

            return false;
        });
    };
    window.progressLoad = function () {
        Swal.fire({
            title: 'Processing...',
            text: 'Please wait while we process your request.',
            allowOutsideClick: false,
            background: '#333', // Dark background color
            color: '#fff', // Light text color
            didOpen: () => {
                Swal.showLoading();
            }
        });
    }
    // Get Ajax data
    window.ajaxGet = function (url, callback) {
        $.ajax({
            url: url,
            type: 'GET',
            headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') },
            beforeSend: function () {
                progressLoad();
            },
            success: function (response) {
                console.log(response);

                if (typeof callback === "function") {
                    callback(response);  // Execute the callback function with response data
                }
                successMessage(response.success)
                Swal.close();
            },
            error: function (xhr) {
                let messageError = "Something went wrong!";
                if (xhr.responseJSON) {
                    let errors = xhr.responseJSON.errors ? xhr.responseJSON.errors : xhr.responseJSON.message;
                    if (typeof errors === "object") {
                        Object.values(errors).forEach(msg => errorSwal(msg));
                    } else if (typeof errors === "string") {
                        errorSwal(errors);
                    } else {
                        errorSwal(messageError);
                    }
                } else if (xhr.responseText) {
                    errorSwal(xhr.responseText);
                } else {
                    errorSwal(messageError);
                }
            }
        });
    };

    // error Messages
    window.errorMessage = function (message) {
        // alert(message);
        Lobibox.notify('error', {
            pauseDelayOnHover: true,
            size: 'mini',
            icon: 'bx bx-x-circle',
            progress: false,
            continueDelayOnInactiveTab: false,
            position: 'top center',
            showProgressbar: false,
            msg: message
        });
    }

    // success Messages
    window.successMessage = function (message) {
        Lobibox.notify('success', {
            pauseDelayOnHover: true,
            size: 'mini',
            icon: 'bx bx-check-circle',
            continueDelayOnInactiveTab: false,
            position: 'top center',
            showProgressbar: false,
            msg: message
        });
    }

    // Function for show/hide password
    window.bindPasswordToggle = function () {
        $(".show_hide_password a").on('click', function (event) {
            event.preventDefault(); // Prevent the default action of the link
            let passwordField = $(this).siblings("input");
            let icon = $(this).find("i");

            // Toggle the password field type between password and text
            if (passwordField.attr("type") === "password") {
                passwordField.attr("type", "text");
                icon.removeClass("bx-hide").addClass("bx-show");
            } else {
                passwordField.attr("type", "password");
                icon.removeClass("bx-show").addClass("bx-hide");
            }
        });
    }

    // for load pages through ajax
    window.loadPage = function (url, targetElement) {
        $.ajax({
            url: url,
            type: "GET",
            dataType: "html",
            cache: false,
            beforeSend: function () {
                $(targetElement).html('<div class="spinner-grow text-info" style="width: 3rem; height: 3rem; text-algin-center " role="status"> <span class="visually-hidden">Loading...</span></div>'); // Show a loading message
            },
            success: function (response) {
                $(targetElement).html(response);
                bindPasswordToggle();
            },
            error: function (xhr, status, error) {
                // console.log(xhr.responseText);

                let response = JSON.parse(xhr.responseText);
                if (response.error) {
                    $(targetElement).html(error + ": " + response.error);
                } else {
                    alert("An unknown error occurred.");
                }
                // console.error("Error loading page:", error);
            }
        });
    }

    // for delete through ajax
    window.confirmDelete = function (callback) {
        Swal.fire({
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            icon: "warning",
            showCancelButton: true,
            theme: 'dark',
            confirmButtonText: "Yes, delete it!",
            buttonsStyling: false,
            customClass: {
                confirmButton: "btn btn-outline-success",
                cancelButton: "btn btn-outline-danger ms-2"
            },
        }).then((result) => {
            if (result.isConfirmed && typeof callback === "function") {
                callback();
            }
        });
    }
    window.handleAjaxRequest = function (url, callback) {
        $.ajax({
            url: url,
            headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') },
            type: 'DELETE',
            success: function (response) {
                // console.log(response);

                Swal.fire({
                    title: "Deleted!",
                    text: response.success,
                    icon: "success",
                    theme: 'dark',
                    timer: 2000,
                    showConfirmButton: false
                }).then(() => {
                    if (typeof callback === "function") {
                        callback(response);  // Execute callback with the response
                    }
                    // location.reload();
                });
                return response;
            },
            error: function (xhr) {
                let messageError = "Something went wrong!";

                if (xhr.responseJSON) {
                    // console.log(xhr.responseJSON);
                    // console.log(xhr.responseJSON?.message);
                    let errors = (xhr.responseJSON.errors) ? xhr.responseJSON.errors : xhr.responseJSON.message;

                    if (typeof errors === "object") {
                        Object.values(errors).forEach(msg => errorSwal(msg));
                    } else if (typeof errors === "string") {
                        errorSwal(errors);
                    } else {
                        errorSwal(messageError);
                    }
                } else if (xhr.responseText) {
                    errorSwal(xhr.responseText);
                } else {
                    errorSwal(messageError);
                }
            }
        });
    }
    window.errorSwal = function (errorMessage) {
        Swal.fire({
            title: "Error!",
            theme: 'dark',
            text: errorMessage,
            icon: "error"
        });
    }

    // for calling ajax modal
    window.showAjaxModal = function (title, btnSuccessText, url) {
        // alert();
        $('#custom-lg-modal').modal('show');
        $('.modal-title').html(title)
        $('.modal-body').html('<div class="spinner-grow text-info" style="width: 3rem; height: 3rem; margin-left:48%; " role="status"> <span class="visually-hidden">Loading...</span></div>');

        $.ajax({
            url: url,
            type: "GET",
            dataType: "html",
            cache: false,
            success: function (response) {
                $('.modal-body').html(response);
                $('.btnSuccessText').html(btnSuccessText)
                // bindPasswordToggle();

            },
            error: function (xhr, status, error) {
                // console.error("Error loading page:", error);
                console.log(xhr.responseJSON, error);

                $(targetElement).html(error);
            }
        });
    }
});
