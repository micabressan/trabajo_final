module hive.util.cthash;

import std.typecons : Nullable;

// Adapted from http://stevehanov.ca/blog/index.php?id=119
// Uses a better hash function to prevent locking up the trial-and-error loop
// Doesn't do the unnecessary -1 hack for 1-slot buckets

struct CtHash(T)
{
	private int[] ds = [];
	private KeyValue!T[] slots = [];
	
	this(T[string] aa)
	{
		import std.algorithm.searching : canFind;
		import std.algorithm.sorting : sort;
		
		uint n = aa.length;
		
		this.ds.length = n;
		this.slots.length = n;
		
		KeyValue!T[][] buckets;
		buckets.length = n;
		foreach (k, v; aa)
		{
			auto h = hash(0, k);
			buckets[mod(h, n)] ~= KeyValue!T(k, v);
		}
		
		buckets.sort!"a.length > b.length"();
		
		bool[] used;
		used.length = n;
		used[] = false;
		
		uint b = 0;
		while (b < buckets.length && buckets[b].length > 1)
		{
			auto bucket = buckets[b];
			
			int d = 1;
			
			uint[] indices;
			do
			{
				assert(d < 10000000);
				
				indices.length = 0;
				foreach (kv; bucket)
				{
					uint index = mod(hash(d, kv.key), n);
					
					if (used[index] || indices.canFind(index))
					{
						d++;
						break;
					}
					
					indices ~= index;
				}
			}
			while (indices.length < bucket.length);
			
			auto h = hash(0, bucket[0].key);
			this.ds[mod(h, n)] = d;
			for (uint i = 0; i < indices.length; i++)
			{
				uint index = indices[i];
				this.slots[index] = bucket[i];
				used[index] = true;
			}
			
			b++;
		}
		
		uint index = 0;
		while (b < buckets.length && buckets[b].length)
		{
			auto bucket = buckets[b];
			assert(bucket.length == 1);
			
			while (used[index])
			{
				index++;
			}
			
			auto h = hash(0, bucket[0].key);
			this.ds[mod(h, n)] = -index;
			this.slots[index] = bucket[0];
			used[index] = true;
			
			b++;
		}
	}
	
	const uint length()
	{
		return this.slots.length;
	}
	
	const bool has(const string key)
	{
		if (this.length == 0)
		{
			return false;
		}
		else
		{
			auto slot = this.findSlot(key);
			return slot.key == key;
		}
	}
	
	const T find(const string key)
	{
		if (this.length == 0)
		{
			throw new KeyNotFound(key);
		}
		else
		{
			auto slot = this.findSlot(key);
			if (slot.key == key)
			{
				return slot.value;
			}
			else
			{
				throw new KeyNotFound(key);
			}
		}
	}
	
	const T find(const string key, T default_)
	{
		if (this.length == 0)
		{
			throw new KeyNotFound(key);
		}
		else
		{
			auto slot = this.findSlot(key);
			if (slot.key == key)
			{
				return slot.value;
			}
			else
			{
				return default_;
			}
		}
	}
	
	const private KeyValue!T findSlot(const string key)
	{
		int d = this.ds[mod(hash(0, key), this.length)];
		
		if (d <= 0)
		{
			return this.slots[-d];
		}
		else
		{
			return this.slots[mod(hash(d, key), this.length)];
		}
	}
	
	const T[string] aa()
	{
		T[string] aa;
		foreach (slot; this.slots)
		{
			aa[slot.key] = slot.value;
		}
		return aa;
	}
}

private struct KeyValue(T)
{
	string key;
	T value;
}

//*
// Jenkins's one-at-a-time hash -- https://en.wikipedia.org/wiki/Jenkins_hash_function#one-at-a-time
private int hash(int d, const string key)
{
	int h = d;
	foreach (char c; key)
	{
		h += c;
		h += h << 10;
		h ^= h >> 6;
	}
	h += h << 3;
	h ^= h >> 11;
	h += h << 15;
	return h;
}
//*/

private uint mod(int n, int m)
{
	int r = n % m;
	return r < 0 ? r + m : r;
}

class KeyNotFound : Exception
{
	this (string key)
	{
		super("Key `" ~ key ~ "` not found");
	}
}

unittest
{
	import std.stdio;
	import std.file;
	import std.array;
	import std.random;
	
	auto dict = File("/usr/share/dict/words").byLineCopy().array();
	auto rnd = Random(42);
	
	foreach (n; 1..100)
	{
		uint[string] aa;
		foreach (word; randomSample(dict, n, rnd))
		{
			aa[word] = uniform!uint(rnd);
		}
		
		CtHash!uint hm = CtHash!uint(aa);
		
		foreach (k, v; aa)
		{
			assert(hm.find(k) == v);
		}
	}
}