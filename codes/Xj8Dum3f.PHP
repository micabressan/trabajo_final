@extends('layouts.app')

@section('content')
<div class="container-full">
    <div class="row">
        <div class="col-md-12">
            <h1 class="bd-title">Calculator</h1><br>
        </div>
    </div>

    <div ng-app="CalculatorApp" ng-controller="CalculatorController">
        {{ Form::open() }}
            <div class="row">
                <div class="col-md-2">
                    <?php $name = 'class'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Platform')) }}
                        {{ Form::select($name, \App\Platform::getPlatforms(), null, ['placeholder' => 'Select platform...', 'class'=>'form-control', 'ng-model'=>$name]) }}
                    </div>
                </div>
                <div class="col-md-2">
                    <?php $name = 'acc_currency'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Acc currency')) }}
                        {{ Form::select($name, ['eur'=>'eur', 'usd'=>'usd', 'czk'=>'czk', 'huf'=>'huf', 'pln'=>'pln', 'hrk'=>'hrk'], null, ['placeholder' => 'Select currency...', 'class'=>'form-control']) }}
                    </div>

                    <?php $name = 'spread'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Spread')) }}
                        {{ Form::select($name, [], null, ['placeholder' => 'Select spread...', 'class'=>'form-control']) }}
                    </div>

                    <?php $name = 'acc_leverage'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Acc. leverage')) }}
                        {{ Form::select($name, [1=>1,5=>5,10=>10,15=>15,33=>33,50=>50,100=>100,200=>200,500=>500], null, ['placeholder' => 'Select leverage...', 'class'=>'form-control']) }}
                    </div>
                </div>
                <div class="col-md-2">
                    <?php $name = 'asset_class'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Asset class')) }}
                        {{ Form::select($name, ['CU'=>'Forex', 'CO'=>'Commodity', 'I'=>'Index', 'EQ'=>'Share'], null, ['placeholder' => 'Select asset class...', 'class'=>'form-control']) }}
                    </div>

                    <?php $name = 'instrument'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Instrument')) }}
                        {{ Form::select($name, [], null, ['placeholder' => 'Select instrument...', 'class'=>'form-control']) }}
                    </div>
                    <?php $name = 'volume'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Volume')) }}
                        {{ Form::text($name, null, ['class'=>'form-control']) }}
                    </div>
                </div>
                <div class="col-md-2">
                    <?php $name = 'open_price'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Open price')) }}
                        {{ Form::text($name, null, ['class'=>'form-control']) }}
                    </div>

                    <?php $name = 'tp'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('TP')) }}
                        {{ Form::text($name, null, ['class'=>'form-control']) }}
                    </div>

                    <?php $name = 'sl'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('SL')) }}
                        {{ Form::text($name, null, ['class'=>'form-control']) }}
                    </div>
                </div>
                <div class="col-md-2">
                    <?php $name = 'hold_days'?>
                    <div class="form-group @if ($errors->has($name)) has-error @endif">
                        {{ Form::label($name, __('Days to hold')) }}
                        {{ Form::text($name, null, ['class'=>'form-control']) }}
                    </div>
                </div>
            </div>
        {{ Form::close() }}

        <table class="table table-condensed">
            <tr>
                <th></th>
                <th>Original currency</th>
                <th>Account currency</th>
            </tr>
            <tr>
                <td>Margin</td>
                <td ng-bind="result()">32</td>
                <td>234</td>
            </tr>
            <tr>
                <td>Spread</td>
                <td>32</td>
                <td>234</td>
            </tr>
        </table>
    </div>
</div>
@endsection


@section('js')
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
    <script>

        angular.module('CalculatorApp', [])
            .controller('CalculatorController', function($scope) {
                $scope.result = function() {
                    return $scope.class;
                    // if ($scope.operator == '+') {
                    //     return $scope.a + $scope.b;
                    // }
                    // if ($scope.operator == '-') {
                    //     return $scope.a - $scope.b;
                    // }
                    // if ($scope.operator == '*') {
                    //     return $scope.a * $scope.b;
                    // }
                    // if ($scope.operator == '/') {
                    //     return $scope.a / $scope.b;
                    // }
                };
            });

        $(document).ready(function () {

        });
    </script>
@endsection