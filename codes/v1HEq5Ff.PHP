<?php
/**
 * @file
 * Provides Drupal\builder\BuilderBase.
 */

namespace Drupal\builder;


use \Drupal\Core\Database\StatementInterface;
use Drupal\Core\Cache\Cache;
use \Drupal\Core\Cache\CacheBackendInterface;


class BuilderBase
{


    protected $cache_id;


    public function __construct()
    {

        if (empty($this->cache_id)) {
            $cache_id = $this->generateCacheId();
            $this->cache_id = $cache_id;
        }
    }


    public static function generateCacheId()
    {

        return 'builder:' . uniqid();
    }

    public static function createBid()
    {

        $user = \Drupal::currentUser();

        $fields = array('uid' => $user->id(), 'created' => REQUEST_TIME, 'status' => 0);
        $bid = db_insert('builder_data')
            ->fields($fields)
            ->execute();


        return $bid;

    }

    public static function getCacheId($bid)
    {
        $language_id = \Drupal::languageManager()->getCurrentLanguage()->getId();
        $cid = "builder:$language_id:$bid";
        return $cid;
    }

    public static function cache_get($cid)
    {

        $cache = \Drupal::cache()->get($cid);

        if (isset($cache->data)) {
            return $cache->data;
        }
        return $cache;

    }

    public static function cache_set($cid, $data)
    {
        $tags = array('module:builder');
        \Drupal::cache()->set($cid, $data, CacheBackendInterface::CACHE_PERMANENT, $tags);

    }

    public static function getData($bid)
    {
        $data = db_select('builder_data', 'b')
            ->fields('b', array('data'))
            ->condition('b.bid', $bid)
            ->execute()
            ->fetchField();

        if (!empty($data)) {
            $data = @unserialize($data);
        } else {
            $data = new \stdClass();
            $data->bid = $bid;
        }

        return $data;

    }

    public static function objToArray($obj, &$arr)
    {

        if (!is_object($obj) && !is_array($obj)) {
            $arr = $obj;
            return $arr;
        }

        foreach ($obj as $key => $value) {
            if (!empty($value)) {
                $arr[$key] = array();
                self::objToArray($value, $arr[$key]);
            } else {
                $arr[$key] = $value;
            }
        }
        return $arr;

    }
}