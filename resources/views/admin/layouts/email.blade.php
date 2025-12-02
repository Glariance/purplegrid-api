<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>{{ $subject ?? config('app.name') }}</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f4f4;
            padding: 40px 15px;
            margin: 0;
        }

        .email-wrapper {
            background: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            max-width: 650px;
            margin: auto;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
        }

        .email-header {
            text-align: center;
            margin: -40px -30px 30px -30px;
            padding: 20px 0;
            background-color: #000000;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }

        .email-header img {
            max-height: 60px;
            width: auto;
        }

        .email-body {
            font-size: 15px;
            line-height: 1.7;
            color: #333333;
        }

        .btn {
            background-color: #ffffff;
            color: rgb(0, 0, 0);
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin: 0 0 10px;
            font-weight: bold;
        }

        .footer {
            font-size: 12px;
            color: #888;
            margin-top: 40px;
            text-align: center;
        }

        h2 {
            color: #222;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .cta-section {
            text-align: center;
            margin-top: 40px;
        }

        .cta-section p {
            color: #333;
            font-size: 15px;
        }
    </style>
</head>

<body>
    <div class="email-wrapper">
        <!-- Header Logo -->
        <div class="email-header">
            <img src="{{ asset(getSetting('site logo', 'adminassets/images/pureserenity-logo.png')) }}"
                alt="{{ getSetting('site name', config('app.name')) }} Logo">
        </div>

        <!-- Email Body Content -->
        @yield('content')

        <!-- Optional CTA Section -->
        <div class="cta-section">
            <p>{{ 'Want to explore more?' }}</p>
            <a href="{{ url('/') }}" target="_blank" class="btn">{{ 'Click to Visit Site' }}</a>
        </div>

        <!-- Footer -->
        <div class="footer">
            &copy;
            {{ getSetting('site footer', date('Y') . ' ' . config('app.name') . '. All rights reserved.') }}
            <div style="margin-top: 10px;">
                <!-- Optional: social links -->
                <a href="https://facebook.com"
                    style="margin: 0 5px; text-decoration: none; color: #3490dc;">Facebook</a> |
                <a href="https://twitter.com" style="margin: 0 5px; text-decoration: none; color: #3490dc;">Twitter</a>
            </div>
        </div>
    </div>
</body>

</html>
