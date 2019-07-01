package com.assessment.services;

import java.util.List;

import com.assessment.data.UserTestSession;
import com.assessment.reports.manager.AssessmentTestData;

public interface UserTestSessionService {

	public UserTestSession findUserTestSession(String user, String testName, String companyId);

	public UserTestSession saveOrUpdate(UserTestSession userTestSession);

	public List<AssessmentTestData> getAllResultsData(String companyId);

	////////////////////////////////////////////////////////////////////////////////////////////////

	public List<String> getUserName(String testName, String companyId);

	public List<String> getCompanyId();

	public List<String> getTestName(String companyId);
	
	
	public List<String>  getTestName_new();
	public List<String> getUserName_new();
	


}
