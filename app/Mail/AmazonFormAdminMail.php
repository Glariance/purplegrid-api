<?php

namespace App\Mail;

use App\Models\AmazonFormSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AmazonFormAdminMail extends Mailable
{
    use Queueable, SerializesModels;

    public AmazonFormSubmission $submission;

    /**
     * Create a new message instance.
     */
    public function __construct(AmazonFormSubmission $submission)
    {
        $this->submission = $submission;
    }

    /**
     * Build the message.
     */
    public function build(): self
    {
        return $this->subject('New Amazon Store Grid Plan Request')
            ->markdown('emails.amazon-form-admin', [
                'submission' => $this->submission,
            ]);
    }
}

