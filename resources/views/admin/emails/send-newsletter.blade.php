@extends('admin.layouts.email')
@section('content')
    <div class="email-body">
        {!! $body['message'] !!}
    </div>
@endsection
