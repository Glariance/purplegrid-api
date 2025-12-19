@component('mail::message')
@php
    $primary = '#7c3aed';
    $deep = '#2b0050';
    $muted = '#4b5563';
@endphp

<div style="text-align:center; margin-bottom: 16px;">
    <img src="{{ (config('app.url') ? rtrim(config('app.url'), '/') : '') . '/adminassets/images/purple-logo.png' }}" alt="{{ config('app.name') }} logo" style="max-width: 180px;">
</div>

<div style="background: linear-gradient(135deg, {{ $deep }} 0%, {{ $primary }} 100%); padding: 24px; border-radius: 12px; margin-bottom: 24px; color: #f3e8ff;">
    <h1 style="margin: 0; font-size: 22px; font-weight: 800; color: #e9d5ff;">New AI Influencer Campaign Request</h1>
    <p style="margin: 8px 0 0; color: #e9d5ff;">A visitor submitted the AI Influencer Campaign form. Details are below.</p>
</div>

@component('mail::panel')
**Summary:** New AI Influencer Campaign request from {{ $submission->full_name }} ({{ $submission->email }})  
**Service:** {{ $submission->service }}  
**Budget:** {{ $submission->budget }}
@endcomponent

<table width="100%" style="border-collapse: collapse; margin: 12px 0;">
    <tbody>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Full Name</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->full_name }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Email</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->email }}</td>
        </tr>
        @if($submission->phone)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Phone</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->phone }}</td>
        </tr>
        @endif
        @if($submission->company_name)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Company Name</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->company_name }}</td>
        </tr>
        @endif
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Service Interested In</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->service }}</td>
        </tr>
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Monthly Budget</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->budget }}</td>
        </tr>
        @if($submission->project_details)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }}; vertical-align: top;">Project Details</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->project_details }}</td>
        </tr>
        @endif
    </tbody>
</table>

Thanks,<br>
{{ config('app.name') }}
@endcomponent

