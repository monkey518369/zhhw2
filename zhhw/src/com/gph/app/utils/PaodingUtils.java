package com.gph.app.utils;

import java.io.IOException;
import java.io.StringReader;
import java.util.LinkedList;
import java.util.List;

import net.paoding.analysis.analyzer.PaodingAnalyzer;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Token;
import org.apache.lucene.analysis.TokenStream;

public class PaodingUtils {

	public static List<String> split(String indexStr) throws IOException{
		
		List<String> res = new LinkedList<String>();
		
		Analyzer analyzer = new PaodingAnalyzer(); 
        StringReader reader = new StringReader(indexStr); 
        TokenStream ts = analyzer.tokenStream(indexStr, reader); 
        Token t = ts.next(); 
        while (t != null) { 
            System.out.print(t.term()+"  "); 
            res.add(t.term());
            t = ts.next(); 
        } 
        
        return res;
	}
}
