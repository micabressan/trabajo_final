<?php

// писал конфиг для приложения

class SettingsController extends \BaseController {

	public function edit () {

        $settings = [
            'site_title' => AppSettings::get('site_title'),
            'meta_description' => AppSettings::get('meta_description'),
            'meta_keywords' => AppSettings::get('meta_keywords'),
            'email_support' => AppSettings::get('email_support'),
            'count_pagination' => AppSettings::get('count_pagination')
        ];

        return View::make('admin.settings')->with('settings', $settings);

    }

    public function save () {

        $param = Input::all();

        $validator = Validator::make($param, [
            'site_title' => 'required',
            'meta_description' => 'required',
            'meta_keywords' => 'required',
            'email_support' => 'required|email',
            'count_pagination' => 'required'
        ]);

        if ( $validator->fails() ) {

            $output = '';

            $errors = $validator->messages()->toArray();

            foreach ($errors as $error) {
                $output .= $error[0] . '<br>';
            }

            return View::make('admin.elements.error')->with('errors', $output);

        }

        AppSettings::set('site_title', $param['site_title']);
        AppSettings::set('meta_description', $param['meta_description']);
        AppSettings::set('meta_keywords', $param['meta_keywords']);
        AppSettings::set('email_support', $param['email_support']);
        AppSettings::set('count_pagination', $param['count_pagination']);

        return Redirect::to(URL::previous());

    }

}