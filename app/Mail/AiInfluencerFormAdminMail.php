<?php

namespace App\Mail;

use App\Models\AiInfluencerFormSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AiInfluencerFormAdminMail extends Mailable
{
    use Queueable, SerializesModels;

    public AiInfluencerFormSubmission $submission;

    /**
     * Create a new message instance.
     */
    public function __construct(AiInfluencerFormSubmission $submission)
    {
        $this->submission = $submission;
    }

    /**
     * Build the message.
     */
    public function build(): self
    {
        return $this->subject('New AI Influencer Campaign Request')
            ->markdown('emails.ai-influencer-form-admin', [
                'submission' => $this->submission,
            ]);
    }
}
