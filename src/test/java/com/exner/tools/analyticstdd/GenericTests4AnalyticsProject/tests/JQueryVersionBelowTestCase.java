package com.exner.tools.analyticstdd.GenericTests4AnalyticsProject.tests;

import com.exner.tools.analyticstdd.GenericTests4AnalyticsProject.Tools;

public class JQueryVersionBelowTestCase extends WebDriverBasedTestCase {
	protected String _maxVersion;

	public JQueryVersionBelowTestCase(String pageURL, String maxVersion) {
		super(pageURL);
		setName("jQuery version before " + maxVersion + " - " + pageURL);
		_maxVersion = maxVersion;
	}

	@Override
	protected void runTest() throws Throwable {
		// check whether DTM has been loaded on the page
		Object response = _jsExecutor.executeScript(
				"if (typeof jQuery !== 'undefined') { return jQuery.fn.jquery } else { return 'unavailable' }");

		// make sure the element exists
		if (String.class.isAssignableFrom(response.getClass())) {
			boolean result = Tools.testVersionIsOlderThanBaseVersion((String) response, _maxVersion);
			assertTrue("jQuery version should be before " + _maxVersion, result);
		} else {
			fail("jQuery version not available");
		}

	}

}