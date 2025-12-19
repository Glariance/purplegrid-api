<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AiInfluencerFormSubmission;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Mail\AiInfluencerFormAdminMail;
use App\Mail\AiInfluencerFormUserMail;

class AiInfluencerFormController extends Controller
{
    /**
     * Store an AI Influencer form submission.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'full_name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255'],
            'phone' => ['nullable', 'string', 'max:50'],
            'company_name' => ['nullable', 'string', 'max:255'],
            'service' => ['required', 'string', 'max:255'],
            'budget' => ['required', 'string', 'max:255'],
            'project_details' => ['nullable', 'string'],
        ]);

        $submission = AiInfluencerFormSubmission::create([
            'full_name' => $validated['full_name'],
            'email' => $validated['email'],
            'phone' => $validated['phone'] ?? null,
            'company_name' => $validated['company_name'] ?? null,
            'service' => $validated['service'],
            'budget' => $validated['budget'],
            'project_details' => $validated['project_details'] ?? null,
            'is_read' => false,
        ]);

        // Send notifications
        $adminEmail = config('mail.from.address') ?: env('MAIL_FROM_ADDRESS');
        try {
            if ($adminEmail) {
                Mail::to($adminEmail)->send(new AiInfluencerFormAdminMail($submission));
            }
            if ($submission->email) {
                Mail::to($submission->email)->send(new AiInfluencerFormUserMail($submission));
            }
        } catch (\Throwable $e) {
            Log::error('Failed to send AI Influencer form emails', [
                'error' => $e->getMessage(),
                'submission_id' => $submission->id
            ]);
            // Don't fail the request if email fails
        }

        return response()->json([
            'success' => true,
            'message' => 'Thank you! We\'ll respond within 24 hours to discuss your AI influencer strategy.',
            'data' => $submission,
        ], 201);
    }
}
