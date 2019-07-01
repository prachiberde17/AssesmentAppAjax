package com.assessment.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.assessment.data.UserTest;
import com.assessment.data.UserTestCompany;
import com.assessment.data.UserTestSession;
import com.assessment.reports.manager.AssessmentTestData;
import com.assessment.repositories.UserTestSessionRepository;
import com.assessment.services.UserTestSessionService;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
//@RequestMapping("/testTask")
public class UserTestSessionTaskController {
	@Autowired
	public UserTestSessionRepository userTestSessionRepository;
	@Autowired
	public UserTestSessionService userTestSessionService;

	@GetMapping("/userTest/{companyId}")
	public ResponseEntity<?> userTest(@PathVariable String companyId) {
		List<UserTestSession> list = userTestSessionRepository.userTestSession(companyId);
		System.out.println("userTestSession:: " + list);
		return ResponseEntity.ok().body(list);
	}

	 

	@PostMapping("/ajax1")
	public @ResponseBody Map<String, Object> call1(UserTest userTest) {
		Map<String, Object> map = new HashMap<>();
		System.out.println("1" + userTest.getCompanyId());
//		System.out.println("2" + companyId);
		System.out.println("123:::    " + userTest.getCompanyId());
		List<String> testList = userTestSessionService.getTestName(userTest.getCompanyId());
		System.out.println(testList);
		map.put("data", testList);
		return map;
	}

	@PostMapping("/userTest2")
	@ResponseBody
	public Map<String, Object> findUserTestSession2(@RequestBody UserTest userTest) {
		Map<String, Object> map = new HashMap<>();
		//System.out.println("===============userTest2====================> company id ::"+userTest.getCompanyId()+ "   test name ::"+userTest.getTestName()+"   emailid ::"+userTest.getUser());
		UserTestSession ut = new UserTestSession();
		ut = userTestSessionService.findUserTestSession(userTest.getUser(), userTest.getTestName(), userTest.getCompanyId());
		System.out.println(ut);

		map.put("data", ut);
		map.put("msg", "data received");
		return map;
	}

	@GetMapping("/userTest1")
	public ModelAndView findUserTestSession(Model theModel) {

		// ModelAndView mav = new ModelAndView("testname");
		ModelAndView mav = new ModelAndView("testname_new2.0");
//		List<?> userList = userTestSessionService.getUserName_new();
//		System.out.println("users ::"+userList);
//		mav.addObject("userList",userList);

//		List<?> testList = userTestSessionService.getTestName_new();
//		System.out.println("test ::"+testList);
//
//		mav.addObject("testList",testList);

		UserTest test = new UserTest();
		mav.addObject("userTest", test);

		UserTestSession testse = new UserTestSession();
		mav.addObject("test", testse);
		
		
		List<?> companyList = userTestSessionService.getCompanyId();
		mav.addObject("companyList", companyList);
		
		

//System.out.println("=================================== company id ::"+userTest.getCompanyId()+ "   test name ::"+userTest.getTestName()+"   emailid ::"+userTest.getUser());

		return mav;

	}

	// create method for returning the proper page

	@GetMapping("/changelist1")
	public ModelAndView changelist1(@RequestParam("companyId") String companyId,
			@ModelAttribute("userTest") UserTest userTest, Model theModel) {

		// ModelAndView mav = new ModelAndView("testname");
		ModelAndView mav = new ModelAndView("testname_new2.0");

		System.out.println("???????????????????????????????????????????????????????????????????");
		System.out.println(" chnagelist 1 CID::" + userTest.getCompanyId());
		

		System.out.println("???????????????????????????????????????????????????????????????????");
		List<?> testList = userTestSessionService.getTestName(userTest.getCompanyId());
		mav.addObject("testList", testList);
		System.out.println("test ::"+testList);

		List<?> companyList = userTestSessionService.getCompanyId();
		mav.addObject("companyList", companyList);


System.out.println("============changelist1======================= company id ::"+userTest.getCompanyId()+ "   test name ::"+userTest.getTestName()+"   emailid ::"+userTest.getUser());
		
		// mav.addObject("companyId",userTest.getCompanyId());
		return mav;
	}

	@GetMapping("/changelist2")
	public ModelAndView changelist2(@RequestParam("companyId") String companyId,
			@RequestParam("testName") String testName, @ModelAttribute("userTest") UserTest userTest, Model theModel) {

		// ModelAndView mav = new ModelAndView("testname");


		System.out.println("==============changelist2===================== company id ::"+userTest.getCompanyId()+ "   test name ::"+userTest.getTestName()+"   emailid ::"+userTest.getUser());
		ModelAndView mav = new ModelAndView("testname_new2.0");
		List<?> userList = userTestSessionService.getUserName(userTest.getTestName(), userTest.getCompanyId());

		mav.addObject("userList", userList);
//		
		UserTest test = new UserTest();
		mav.addObject("user", test);
		List<?> testList = userTestSessionService.getTestName(userTest.getCompanyId());
		mav.addObject("testList", testList);
		System.out.println("test ::"+testList);
		List<?> companyList = userTestSessionService.getCompanyId();
		mav.addObject("companyList", companyList);
		System.out.println("==============changelist2=====================>test ::"+testList);
		return mav;
	}

	@GetMapping("/allData")
	public ModelAndView getAllData() {
		ModelAndView mav = new ModelAndView("allDataPage");
		List<?> companyList = userTestSessionService.getCompanyId();
		System.out.println("company id ::" + companyList);
		mav.addObject("companyIdList", companyList);
		return mav;
	}

	// create a method for processing data

	@PostMapping("/allData2")
	@ResponseBody
	public Map<String, List<?>> allDataResult(@RequestBody UserTestCompany userTestCompany) {
		Map<String, List<?>> map = new HashMap<>();
		System.out.println("company id ::" + userTestCompany.companyId);
		List<AssessmentTestData> list = userTestSessionService.getAllResultsData(userTestCompany.companyId);
		// System.out.println("list data::"+ list);

		map.put("data", list);
		// map.put("msg", "data received");
		// System.out.println(data.);
		return map;
	}

//	@PostMapping("/allData2")
//	@ResponseBody
//	public  List<?> allDataResult(@RequestBody UserTestCompany userTestCompany)
//	{
//		System.out.println("company id ::"+userTestCompany.companyId);
//		List<AssessmentTestData> data =userTestSessionService.getAllResultsData(userTestCompany.companyId);		
//		System.out.println("list data::"+ data);
//		
//		System.out.println(data);
//		return data;
//	}

	@GetMapping("/userTest/a1/{companyId}")
	public ResponseEntity<?> getAllResultsData(@PathVariable String companyId) {// AssessmentTestData ad=new
																				// AssessmentTestData();
		List<AssessmentTestData> list = userTestSessionService.getAllResultsData(companyId);
		System.out.println("ALL DATA:" + list);
		return ResponseEntity.ok().body(list);
	}

}
