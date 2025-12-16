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
    <h1 style="margin: 0; font-size: 22px; font-weight: 800; color: #e9d5ff;">New Amazon Store Grid Plan Request</h1>
    <p style="margin: 8px 0 0; color: #e9d5ff;">A visitor submitted the Amazon Store Grid builder form. Details are below.</p>
</div>

@component('mail::panel')
**Summary:** New Grid Plan request{{ $submission->name ? ' from ' . $submission->name : '' }}{{ $submission->email ? ' (' . $submission->email . ')' : '' }}  
**Niche:** {{ $submission->niche ?? 'Not specified' }}  
**Location:** {{ $submission->location ?? 'Not specified' }}  
**Revenue:** {{ $submission->revenue ?? 'Not specified' }}
@endcomponent

<table width="100%" style="border-collapse: collapse; margin: 12px 0;">
    <tbody>
        @if($submission->name)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Name</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->name }}</td>
        </tr>
        @endif
        @if($submission->email)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Email</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->email }}</td>
        </tr>
        @endif
        @if($submission->phone)
        <tr>
            <td style="padding: 8px; border: 1px solid #e5e7eb; background: #f9fafb; font-weight: 600; color: {{ $muted }};">Phone</td>
            <td style="padding: 8px; border: 1px solid #e5e7eb;">{{ $submission->phone }}</td>
        </tr>
        @endif
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

Thanks,<br>
{{ config('app.name') }}
@endcomponent

