package com.assessment.data;

public class UserTest {

	String user;
	String testName;
	String companyId;
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getTestName() {
		return testName;
	}
	public void setTestName(String testName) {
		this.testName = testName;
	}
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	@Override
	public String toString() {
		return "UserTest [user=" + user + ", testName=" + testName + ", companyId=" + companyId + "]";
	}
	
	
	
}
