<?php

namespace App\Mail;

use App\Models\AiInfluencerFormSubmission;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AiInfluencerFormUserMail extends Mailable
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
        return $this->subject('Thank You for Your AI Influencer Campaign Request')
            ->markdown('emails.ai-influencer-form-user', [
                'submission' => $this->submission,
            ]);
    }
}
