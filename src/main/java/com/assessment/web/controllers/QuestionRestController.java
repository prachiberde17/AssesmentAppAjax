package com.assessment.web.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class QuestionRestController {
	@PostMapping({ "/helloWorld22" })
	public ResponseEntity<?> helloWorld22(@RequestBody String message) {
		System.out.println(message);
		return ResponseEntity.ok().body("Recieved message...  " + message);
	}


}
