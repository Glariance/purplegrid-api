<?php

namespace App\Mail;

use App\Models\AmazonFormSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AmazonFormUserMail extends Mailable
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
        return $this->subject('Your Amazon Store Grid Plan Request')
            ->markdown('emails.amazon-form-user', [
                'submission' => $this->submission,
            ]);
    }
}

