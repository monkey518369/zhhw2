package com.gph.app.utils;

import java.util.Comparator;

public class MapKeyComparator implements Comparator<Integer> {

	@Override
	public int compare(Integer t1, Integer t2) {
		 return t1.compareTo(t2);  
	}

}
