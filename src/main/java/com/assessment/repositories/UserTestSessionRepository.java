package com.assessment.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.assessment.data.UserTestSession;
import com.assessment.reports.manager.AssessmentTestData;

public interface UserTestSessionRepository extends JpaRepository<UserTestSession, Long> {

	/* working */ @Query("SELECT u FROM UserTestSession u WHERE u.user=:user and u.testName=:testName and u.companyId=:companyId")
	UserTestSession findByPrimaryKey(@Param("user") String user, @Param("testName") String testName,
			@Param("companyId") String companyId);

	// -------------------------------------------------------------------------------------------
	@Query("SELECT "
			+ "    new com.assessment.reports.manager.AssessmentTestData(u.percentageMarksRecieved, u.testName, u.user, u.noOfAttempts, u.pass, u.sectionResults, u.companyId, u.testInviteSent, u.sharedDirect, u.sectionsNoOfQuestionsNotAnswered, u.createDate, u.updateDate) "
			+ "FROM " + "    UserTestSession u where u.companyId=:companyId " + "GROUP BY "
			+ "    u.testName, u.user ORDER BY u.createDate desc")
	List<AssessmentTestData> getAllResultsData(@Param("companyId") String companyId);

	// ------------------------------------------------------------------------------
	@Query("SELECT u FROM UserTestSession u WHERE u.testName=:testName and u.companyId=:companyId ORDER BY u.createDate desc, u.percentageMarksRecieved desc")
	List<UserTestSession> findUserSessionsForTest(@Param("testName") String testName,
			@Param("companyId") String companyId);

	// --------------------------------------------------------------

	/* working */ @Query("FROM UserTestSession q WHERE q.companyId=:companyId")
	public List<UserTestSession> userTestSession(@Param("companyId") String companyId);

	@Query(" SELECT DISTINCT u.user From UserTestSession u where u.companyId=:companyId and u.testName=:testName")
	public List<String> getUserName(@Param("testName") String testName, @Param("companyId") String companyId);

	@Query("SELECT DISTINCT u.companyId from UserTestSession u ")
	public List<String> getCompanyId();

	@Query("SELECT  DISTINCT u.testName from UserTestSession u where u.companyId=:companyId")
	public List<String> getTestName(@Param("companyId") String companyId);
	
	
	
	
	@Query("SELECT DISTINCT u.testName From UserTestSession u ")
	public List<String> getTestName_new();
	
	
	@Query("SELECT DISTINCT u.user From UserTestSession u")
	public List<String> getUserName_new();
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
