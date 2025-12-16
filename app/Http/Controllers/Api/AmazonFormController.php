<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AmazonFormSubmission;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Mail\AmazonFormAdminMail;
use App\Mail\AmazonFormUserMail;

class AmazonFormController extends Controller
{
    /**
     * Store an Amazon form submission.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'niche' => ['nullable', 'string', 'max:255'],
            'location' => ['nullable', 'string', 'max:255'],
            'revenue' => ['nullable', 'string', 'max:255'],
            'ad_budget' => ['nullable', 'string', 'max:255'],
            'business_type' => ['nullable', 'string', 'max:255'],
            'grid_team' => ['nullable', 'array'],
            'grid_team.*' => ['string', 'max:255'],
            'email' => ['nullable', 'string', 'email', 'max:255'],
            'name' => ['nullable', 'string', 'max:255'],
            'phone' => ['nullable', 'string', 'max:50'],
        ]);

        $submission = AmazonFormSubmission::create([
            'niche' => $validated['niche'] ?? null,
            'location' => $validated['location'] ?? null,
            'revenue' => $validated['revenue'] ?? null,
            'ad_budget' => $validated['ad_budget'] ?? null,
            'business_type' => $validated['business_type'] ?? null,
            'grid_team' => $validated['grid_team'] ?? null,
            'email' => $validated['email'] ?? null,
            'name' => $validated['name'] ?? null,
            'phone' => $validated['phone'] ?? null,
            'is_read' => 0,
        ]);

        // Send notifications
        $adminEmail = config('mail.from.address') ?: env('MAIL_FROM_ADDRESS');
        try {
            if ($adminEmail) {
                Mail::to($adminEmail)->send(new AmazonFormAdminMail($submission));
            }
            if ($submission->email) {
                Mail::to($submission->email)->send(new AmazonFormUserMail($submission));
            }
        } catch (\Throwable $e) {
            report($e);
            return response()->json([
                'success' => false,
                'message' => 'Form submitted, but emails could not be sent. Please try again later.',
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'Thank you! Your custom Grid plan is being generated.',
            'data' => $submission,
        ], 201);
    }
}

