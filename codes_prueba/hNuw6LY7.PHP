<?php
/**
 * Created by PhpStorm.
 * User: NotePad
 * Date: 21.08.2015
 * Time: 17:51
 */
class Routing
{
    public static $routeTable;

    function __construct()
    {
        self::$routeTable = Configuration::routeTable();
    }

    public static function sortRouteTable()
    {
        $empArr = array();
        foreach(self::$routeTable as $key => $value) {
            foreach($value as $k => $v) {
                if($v === array()) {
                    array_push($empArr, self::$routeTable[$key]);
                    unset(self::$routeTable[$key]);
                }
            }
        }
        self::$routeTable = array_merge(self::$routeTable, $empArr);
    }

    public static function parse()
    {
        self::sortRouteTable();

        $arr = explode("?", $_SERVER["REQUEST_URI"]);
        $name = $arr[0];
        $params = array();
        if (isset($arr[1]) && $arr[1]) {
        $params = explode("&", $arr[1]);
        }

        $newParams = array();
        foreach ($params as $key => $value) {
            $ps = explode("=", $value);
            $newParams[$ps[0]] = $ps[1];
        }
        $arrParams = array();
        foreach($newParams as $k => $v) {
            array_push($arrParams, $k);
        }
        $newParamsPost = array();
        if($_SERVER['REQUEST_METHOD'] == 'POST') {
            $newParamsPost = $_POST;
        }

        $req = new Request();
        $req->setGetParameters($newParams);
        $req->setPostParameters($newParamsPost);
        $controllerName = null;
        $actionName = null;
        foreach(self::$routeTable as $k => $v) {
            if($v[0] == $name) {
                $paramName = array_intersect($v[3], $arrParams);
                if(count($paramName) == count($arrParams)) {
                    $controllerName = $v[1];
                    $actionName = $v[2];
                }
            }
        }
        if($actionName == null && $controllerName == null) {
            echo 'Unknown page'; die;
        }
        $controllerName = ucfirst($controllerName.'Controller');
        $class = new $controllerName();

        return $class->{$actionName.'Action'}($req);
    }

    public static function generateUrl($routeName, $routeParams = array())
    {

        $str = array();
        $paramsForControl = array();
        if($routeParams != array()) {
            foreach ($routeParams as $k => $v) {
                array_push($str, $k . '=' . $v);
                array_push($paramsForControl, $k);
            }
            $param = implode('&', $str);
            $rezRoute = self::$routeTable[$routeName][0].'?'.$param;
        } else {
            $rezRoute = self::$routeTable[$routeName][0];
        }
        $arrDiff1 = array();
        $arrDiff2 = array();
        $arrDiff1 = array_diff($paramsForControl, self::$routeTable[$routeName][3]);
        $arrDiff2 = array_diff(self::$routeTable[$routeName][3], $paramsForControl);
        if($arrDiff1 == array() && $arrDiff2 == array()) {
            return $rezRoute;
        } else {
            echo 'You enter not enough params'; die;
        }
    }
}
?>