<?php
namespace App\Http\Controllers;

use App\Models\Article;
//use GrahamCampbell\Markdown\Facades\Markdown;

class HomeController extends Controller
{
    public function index()
    {
        $articles = Article::where('online', 1)
               ->orderBy('created_at', 'desc')
               ->take(7)
               ->get();
               
        $articlesUpdated = Article::where('online', 1)
               ->orderBy('updated_at', 'desc')
               ->take(7)
               ->get();

        return view('home.index', compact('articles','articlesUpdated'));
    }
}