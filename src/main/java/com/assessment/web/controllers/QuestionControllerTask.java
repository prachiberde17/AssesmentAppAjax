package com.assessment.web.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.assessment.data.Question;
import com.assessment.data.User;
import com.assessment.data.UserTestSession;
import com.assessment.repositories.QuestionRepository;
import com.assessment.services.QuestionService;
import com.assessment.services.UserTestSessionService;

@RestController
@RequestMapping("/task")
public class QuestionControllerTask {
	@Autowired
	private QuestionRepository questionRepository;
	@Autowired
	private QuestionService questionService;
	@Autowired
	private UserTestSessionService userTestSession;

	@GetMapping("/questions/{companyId}")
	public ResponseEntity<?>findQuestions(@PathVariable String companyId)
	{
		List<Question> list = questionService.findQuestions(companyId);
		System.out.println(list);
		return ResponseEntity.ok().body(list);
	}

}