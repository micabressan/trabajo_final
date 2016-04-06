<?php

class CabController extends \BaseController {

	public function getSoftware () {

        $data = [
            'data' => File::get(storage_path() . '/pages/pageSoftware.pg'),
            'files' => H::getSoftwareLinks(false)
        ];

        return View::make('cab.uSoftware')->with('data', $data);

    }
    public function editFormSoftware () {

        $data = [
            'data' => File::get(storage_path() . '/pages/pageSoftware.pg'),
            'files' => H::getSoftwareLinks()
        ];

        return View::make('cab.editSoftware')->with('data', $data);

    }
    public function editSoftware () {

        if (File::put(storage_path() . '/pages/pageSoftware.pg', Input::get('body'))) {
            return Redirect::to(Data::$d['adminpanel']['url'] . 'cab/software/');
        } else {
            return View::make('admin.elements.error')->with('errors', 'Форма не була заповнена');
        }

    }
    public function addSoftware () {

        $files = Input::file('files');
        $destinationPath = public_path() . '/storage/uploads/software';

        foreach($files as $file) {
            // validating each file.
            $rules = array('file' => 'required'); //'required|mimes:png,gif,jpeg,txt,pdf,doc'
            $validator = Validator::make(array('file'=> $file), $rules);
            if($validator->passes()){
                // path is root/uploads
                $filename = $file->getClientOriginalName();
                $data['path'][] = $filename;
                $upload_success = $file->move($destinationPath, $filename);
            }
            else {
                // redirect back with errors.
                return Redirect::to(URL::previous())->withInput()->withErrors($validator);
            }
        }

        return Redirect::to(URL::previous());

    }
    public function deleteSoftware ($path) {
        //echo public_path() . '/storage/uploads/software/' . $path;
        File::delete(public_path() . '/storage/uploads/software/' . $path);
        return Redirect::to(URL::previous());
    }

    public function getArticle () {
        return View::make('cab.article')->with('data', File::get(storage_path() . '/pages/pageArticle.pg'));
    }
    public function editArticle () {
        if (File::put(storage_path() . '/pages/pageArticle.pg', Input::get('body'))) {
            return Redirect::to(URL::previous());
        } else {
            return View::make('admin.elements.error')->with('errors', 'Не вдалося зберегти файл');
        }
    }

    /*    public function getSpec () {
            return View::make('cab.specKurs')->with('data', File::get(storage_path() . '/pages/pageCarrier.pg'));
        }
        public function editSpec () {
            if (File::put(storage_path() . '/pages/pageCarrier.pg', Input::get('body'))) {
                return Redirect::to(URL::previous());
            } else {
                return View::make('admin.elements.error')->with('errors', 'No write file');
            }
        }*/

    public function getLegislation () {
        return View::make('cab.legislation')->with('data', File::get(storage_path() . '/pages/pageLegislation.pg'));
    }
    public function editLegislation () {
        if (File::put(storage_path() . '/pages/pageLegislation.pg', Input::get('body'))) {
            return Redirect::to(URL::previous());
        } else {
            return View::make('admin.elements.error')->with('errors', 'Не вдалося зберегти файл');
        }
    }

    public function getConsult () {
        return View::make('cab.consult')->with('data', File::get(storage_path() . '/pages/pageConsult.pg'));
    }
    public function editConsult () {
        if (File::put(storage_path() . '/pages/pageConsult.pg', Input::get('body'))) {
            return Redirect::to(URL::previous());
        } else {
            return View::make('admin.elements.error')->with('errors', 'Не вдалося зберегти файл');
        }
    }

}