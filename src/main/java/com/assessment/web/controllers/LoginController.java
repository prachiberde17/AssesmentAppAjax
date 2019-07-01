package com.assessment.web.controllers;

import java.net.URLEncoder;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.assessment.common.CommonUtil;
import com.assessment.common.PropertyConfig;
import com.assessment.common.util.EmailGenericMessageThread;
import com.assessment.data.Company;
import com.assessment.data.DifficultyLevel;
import com.assessment.data.Question;
import com.assessment.data.Test;
import com.assessment.data.User;
import com.assessment.services.CompanyService;
import com.assessment.services.QuestionService;
import com.assessment.services.TestService;
import com.assessment.services.UserService;
import com.assessment.web.dto.TestUserData;

@Controller
public class LoginController {
	@Autowired
	UserService userService;
	@Autowired
	QuestionService questionService;
	@Autowired
	CompanyService companyService;
	@Autowired
	TestService testService;

	@Autowired
	PropertyConfig propertyConfig;

	private final String prefixURL = "iiht_html";

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("index");
		User user = new User();
		user.setEmail("system.assessment@iiht.com");
		user.setPassword("1234");
		user.setCompanyName("iiht");
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView showRoot(HttpServletRequest request, HttpServletResponse response) {
		return showLogin(request, response);
	}

	// it shows public data
	@RequestMapping(value = "/publicTest", method = RequestMethod.GET)
	public ModelAndView showPublicTest(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("publicTest3");
		User user = new User();
		TestUserData testUserData = new TestUserData();
		String testId = request.getParameter("testId");
		String companyId = request.getParameter("companyId");
		String inviteSent = request.getParameter("inviteSent");
		if (inviteSent != null) {
			request.getSession().setAttribute("inviteSent", inviteSent);
		}
		Company company = companyService.findByCompanyId(companyId);
		if (company == null) {
			return mav;
		}
		user.setCompanyName(company.getCompanyName());
		user.setCompanyId(company.getCompanyId());
		testUserData.setUser(user);
		Test test = testService.findTestById(Long.parseLong(testId));
		testUserData.setTestId(test.getId() + "");
		testUserData.setTestName(test.getTestName());
		request.getSession().setAttribute("user", user);
		mav.addObject("testUserData", testUserData);

		return mav;
	}

	@RequestMapping(value = "/publicTestAuthenticate", method = RequestMethod.POST)
	public ModelAndView publicTestAuthenticate(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("testUserData") TestUserData testUserData) {

		testUserData.getUser().setPassword("12345");
		Test test = testService.findTestById(Long.parseLong(testUserData.getTestId()));
		boolean validate = validateDomainCheck(test, testUserData.getUser().getEmail());
		if (!validate) {
			ModelAndView mav = new ModelAndView("studentNoTest_Domain");
			mav.addObject("firstName", testUserData.getUser().getFirstName());
			mav.addObject("lastName", testUserData.getUser().getLastName());
			mav.addObject("domain", test.getDomainEmailSupported());
			return mav;
		}
		userService.saveOrUpdate(testUserData.getUser());
		request.getSession().setAttribute("user", testUserData.getUser());

		request.getSession().setAttribute("test", test);
		if (testUserData.getUser() == null) {
			return showPublicTest(request, response);
		}
		String userId = URLEncoder
				.encode(Base64.getEncoder().encodeToString(testUserData.getUser().getEmail().getBytes()));
		String companyId = URLEncoder.encode(test.getCompanyId());
		String inviteSent = (String) request.getSession().getAttribute("inviteSent");
		String append = "";
		if (inviteSent != null) {
			append += "&inviteSent=" + inviteSent;
		}
		String url = "redirect:/startTestSession?userId=" + userId + "&companyId=" + companyId + "&testId="
				+ test.getId() + append + "&sharedDirect=yes";
		ModelAndView mav = new ModelAndView(url);
		return mav;
	}

	private boolean validateDomainCheck(Test test, String email) {
		if (test.getDomainEmailSupported() == null || test.getDomainEmailSupported().trim().length() == 0
				|| test.getDomainEmailSupported().equals("*")) {
			return true;
		}

		String dom = email.substring(email.indexOf("@") + 1, email.length());
		if (test.getDomainEmailSupported().contains(dom)) {
			return true;
		}

		return false;
	}

	@RequestMapping(value = "/problem", method = RequestMethod.GET)
	public ModelAndView problem(HttpServletRequest request, HttpServletResponse response) {

		String stack = (String) request.getSession().getAttribute("errorStack");
		if (stack != null) {
			EmailGenericMessageThread client = new EmailGenericMessageThread("jatin.sutaria@thev2technologies.com",
					"Error in Assessment Platform", stack, propertyConfig);
			Thread th = new Thread(client);
			th.start();
		}
		request.getSession().invalidate();
		ModelAndView mav = new ModelAndView("errorPage");

		return mav;
	}

	@RequestMapping(value = "/signoff", method = RequestMethod.GET)
	public ModelAndView signoff(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().invalidate();
		ModelAndView mav = new ModelAndView("index");
		User user = new User();
		user.setEmail("system@iiiht.com");
		user.setPassword("1234");
		user.setCompanyName("IIHT");
		mav.addObject("user", user);
		return mav;
	}

	@RequestMapping(value = "/authenticate", method = RequestMethod.POST)
	public ModelAndView authenticate(HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("user") User user) {
		ModelAndView mav = null;
		System.out.println("test.........    " + user);
		user = userService.authenticate(user.getEmail(), user.getPassword(), user.getCompanyName());
		System.out.println("test2.........    " + user);
		if (user == null) {
			// navigate to exception page
			mav = new ModelAndView("index");
			user = new User();
			mav.addObject("user", user);
			mav.addObject("message", "Invalid Credentials ");// later put it as label
			mav.addObject("msgtype", "Failure");
			return mav;

		}

		else {
			// to dashboard
			// List<Question> questions =
			// questionService.findQuestions(user.getCompanyId());
			Page<Question> questions = questionService.findQuestionsByPage(user.getCompanyId(), 0);
			request.getSession().setAttribute("user", user);
			request.getSession().setAttribute("companyId", user.getCompanyId());
			// request.getSession().setAttribute("questions", questions);
			System.out.println("test3.........    " + user);
			mav = new ModelAndView("redirect:/showReports");
			mav.addObject("qs", questions.getContent());
			mav.addObject("levels", DifficultyLevel.values());
			CommonUtil.setCommonAttributesOfPagination(questions, mav.getModelMap(), 0, "question_list", null);
		}

		return mav;
	}

	@RequestMapping(value = "/addQ", method = RequestMethod.GET)
	public ModelAndView addQ(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("add_question");

		return mav;
	}

	@RequestMapping(value = "/listQ", method = RequestMethod.GET)
	public ModelAndView listQ(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("question_list");

		return mav;
	}
}
