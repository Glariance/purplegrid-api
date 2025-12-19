@component('mail::message')
@php
    $primary = '#7c3aed';
    $deep = '#2b0050';
    $muted = '#4b5563';
    $logo = (config('app.url') ? rtrim(config('app.url'), '/') : '') . '/adminassets/images/purple-logo.png';
@endphp

<div style="text-align:center; margin-bottom: 16px;">
    <img src="{{ $logo }}" alt="{{ config('app.name') }} logo" style="max-width: 180px;">
</div>

<div style="background: linear-gradient(135deg, {{ $deep }} 0%, {{ $primary }} 100%); padding: 24px; border-radius: 12px; margin-bottom: 24px; color: #f3e8ff;">
    <h1 style="margin: 0; font-size: 22px; font-weight: 800; color: #e9d5ff;">Thank You for Your AI Influencer Campaign Request</h1>
    <p style="margin: 8px 0 0; color: #e9d5ff;">We've received your request and our team will review it within 24 hours.</p>
</div>

@component('mail::panel')
Here's a summary of your AI Influencer Campaign request:
@endcomponent

<table width="100%" style="border-collapse: collapse; margin: 12px 0;">
    <tbody>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Service Interested In</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->service }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Monthly Budget</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->budget }}</td>
        </tr>
        @if($submission->company_name)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Company Name</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->company_name }}</td>
        </tr>
        @endif
        @if($submission->project_details)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }}; vertical-align: top;">Project Details</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->project_details }}</td>
        </tr>
        @endif
    </tbody>
</table>

Our team will review your requirements and prepare a customized AI Influencer strategy for your business. We'll be in touch within 24 hours to discuss your campaign in detail.

If any details need correcting, just reply to this email.

Thanks,<br>
{{ config('app.name') }}
@endcomponent

