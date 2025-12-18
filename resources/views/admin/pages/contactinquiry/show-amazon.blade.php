<div class="card-body">
    <div class="mb-3 text-end">
        <a href="javascript:;"
            onclick="showAjaxModal('Amazon Form Response', 'Send', '{{ route('admin.newsletter-management.send-mail-view', ['email' => $submission->email, 'subject' => 'Amazon Form Inquiry - ' . $submission->niche, 'type' => 'amazon']) }}')"
            class="btn btn-light">
            <i class="lni lni-envelope"></i>
            Send Mail
        </a>
    </div>
    <table class="table table-bordered">
        <tr>
            <th class="w-25">Name</th>
            <td class="w-75">{{ $submission->name }}</td>
        </tr>
        <tr>
            <th>Email</th>
            <td>{{ $submission->email }}</td>
        </tr>
        <tr>
            <th>Phone</th>
            <td>{{ $submission->phone ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Niche</th>
            <td>{{ $submission->niche ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Target Location</th>
            <td>{{ $submission->location ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Anticipated Monthly Revenue</th>
            <td>{{ $submission->revenue ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Monthly Ad Budget</th>
            <td>{{ $submission->ad_budget ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Business Type</th>
            <td>{{ $submission->business_type ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Grid Team Members</th>
            <td>
                @if($submission->grid_team && is_array($submission->grid_team))
                    <ul class="list-unstyled mb-0">
                        @foreach($submission->grid_team as $member)
                            <li><span class="badge bg-primary">{{ $member }}</span></li>
                        @endforeach
                    </ul>
                @else
                    N/A
                @endif
            </td>
        </tr>
        <tr>
            <th>Received At</th>
            <td>{{ $submission->created_at->format('d M Y, h:i A') }}</td>
        </tr>
    </table>
</div>

