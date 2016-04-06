<?php

namespace Site;

use Illuminate\Database\Eloquent\Model;

class Receitas extends Model
{
    protected $table = 'receitas';

    public $timestamps = false;


    function categorias(){
            $this->belongsTo('Site\CategoriasReceitas', 'x', 'y');
    }
}


namespace Site;

use Illuminate\Database\Eloquent\Model;

class CategoriasReceitas extends Model
{
    protected $table = 'receitas_cetegorias';

    public $timestamps = false;


    

    public function receitas(){
            $this->hasMany('Site\Receitas', 'x', 'y');
            //$this->hasMany('Site\Receitas', 'x', 'y');
    }

    }


namespace Site\Http\Controllers;

use Illuminate\Http\Request;

use Site\Http\Requests;
use Site\Http\Controllers\Controller;

use Site\CategoriasReceitas;

class ReceitasController extends Controller
{



    public function Categorias($id){



    	$sql = CategoriasReceitas::where('slug', $id)
        ->with('receitas')
        ->paginate(15);
    	
        //$sql->receitas()->paginate(15);


    	//return $sql = Receitas::All($id);


    	
    	    
    	return view('receitas.home')->with('sql', $sql);
    }
}