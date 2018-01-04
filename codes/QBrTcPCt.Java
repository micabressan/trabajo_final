package cachingSystem.classes;

import cachingSystem.classes.*;
import cachingSystem.interfaces.*;
import dataStructures.classes.*;


/**
 * Class that adapts the FIFOCache class to the ObservableCache abstract class.
 */
public class ObservableFIFOCache<K, V> extends ObservableCache<K, V> {
@SuppressWarnings("rawtypes")
private FIFOCache fifoCache = new FIFOCache();
    @SuppressWarnings("unchecked")
    @Override
    public V get(K key) {
        // TODO Auto-generated method stub
        if (fifoCache.get(key) == null) {
            this.onMiss(key);
        } else {
            this.onHit(key);
        }
        return (V) fifoCache.get(key);
    }

    @SuppressWarnings("unchecked")
    @Override
    public void put(K key, V value) {
        // TODO Auto-generated method stub
        this.clearStaleEntries();
        this.onUpdate(key, value);
        fifoCache.put(key, value);
                
    }

    @Override
    public int size() {
        // TODO Auto-generated method stub
        return fifoCache.size();
    }

    @Override
    public boolean isEmpty() {
        // TODO Auto-generated method stub
        return fifoCache.isEmpty();
    }

    @Override
    public V remove(K key) {
        return (V) fifoCache.remove(key);
    }

    @Override
    public void clearAll() {
        // TODO Auto-generated method stub
        fifoCache.clearAll();
        
    }

    @Override
    public Pair<K, V> getEldestEntry() {
        // TODO Auto-generated method stub
        return fifoCache.getEldestEntry();
    }

    /* TODO: implement the methods from ObservableCache and Cache */

    /* TODO: when adding a new key (the put method), don't forget to call clearStaleEntries */
}