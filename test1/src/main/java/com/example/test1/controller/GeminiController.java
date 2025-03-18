package com.example.test1.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;

import com.example.test1.dao.GeminiService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/gemini")
public class GeminiController {

    private final GeminiService geminiService;
    
    @GetMapping("/gemini.do") 
    public String gemini(Model model) throws Exception{
        return "gemini"; 
    }
    
    @GetMapping("/chat")
    public ResponseEntity<?> gemini(@RequestParam String input) {
        try {
            return ResponseEntity.ok().body(geminiService.getContents(input));
        } catch (HttpClientErrorException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
