package com.zybots.mediqueue.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/language")
public class LanguageController {

    @Autowired
    private MessageSource messageSource;

    @GetMapping("/welcome")
    public ResponseEntity<String> getWelcomeMessage() {
        // This automatically detects the language and grabs the right text from the properties files!
        String message = messageSource.getMessage("welcome.message", null, LocaleContextHolder.getLocale());
        return ResponseEntity.ok(message);
    }
}