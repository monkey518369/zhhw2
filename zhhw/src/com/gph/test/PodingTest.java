package com.gph.test;

import java.io.IOException;
import java.io.StringReader;

import net.paoding.analysis.analyzer.PaodingAnalyzer;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Token;
import org.apache.lucene.analysis.TokenStream;

public class PodingTest {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		  Analyzer analyzer = new PaodingAnalyzer(); 
          String  indexStr = "我的QQ号码是3453245"; 
          StringReader reader = new StringReader(indexStr); 
          TokenStream ts = analyzer.tokenStream(indexStr, reader); 
          Token t = ts.next(); 
          while (t != null) { 
              System.out.print(t.termText()+"  "); 
              t = ts.next(); 
          } 
	}

}
