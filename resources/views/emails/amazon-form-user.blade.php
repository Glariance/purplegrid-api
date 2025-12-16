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
    <h1 style="margin: 0; font-size: 22px; font-weight: 800; color: #e9d5ff;">We received your Grid Plan request</h1>
    <p style="margin: 8px 0 0; color: #e9d5ff;">Thanks for building your custom Amazon Store Grid. Our team will review your requirements and get back to you shortly.</p>
</div>

@component('mail::panel')
Here's a summary of your Grid Plan request:
@endcomponent

<table width="100%" style="border-collapse: collapse; margin: 12px 0;">
    <tbody>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Niche</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->niche ?? 'Not specified' }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Target Location</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->location ?? 'Not specified' }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Anticipated Monthly Revenue</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->revenue ?? 'Not specified' }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Monthly Ad Budget</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->ad_budget ?? 'Not specified' }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Business Type</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->business_type ?? 'Not specified' }}</td>
        </tr>
        @if($submission->grid_team && count($submission->grid_team) > 0)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Selected Grid Team</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">
                <ul style="margin: 0; padding-left: 20px;">
                    @foreach($submission->grid_team as $role)
                        <li>{{ $role }}</li>
                    @endforeach
                </ul>
            </td>
        </tr>
        @endif
    </tbody>
</table>

Our team will review your requirements and prepare a customized Grid Plan for your Amazon store. We'll be in touch soon!

If any details need correcting, just reply to this email.

Thanks,<br>
{{ config('app.name') }}
@endcomponent

