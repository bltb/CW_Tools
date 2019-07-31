package com.jeremyc.jbehave.steps;

import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Pending;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.joda.time.LocalTime;

import java.util.List;

import static org.fest.assertions.Assertions.assertThat;


public class FindMissingByComparingDirSetsSteps {

    @Given("a directory set $setA consisting of directory $dirA containing file $file1 with checksum $checksum1 and file $file2 with checksum $checksum2 and directory set $setB consisting of directory $dirB containing file $file3 with checksum $checksum3")
    @Pending
    public void givenDirectorySet(  String setA,
                                    String dirA,
                                    String file1,
				    String checksum1,
                                    String file2,
                                    String checksum2,
                                    String setB,
                                    String dirB,
                                    String file3,
                                    String checksum3) {
    }

    @When("I want to list missing files")
    @Pending
    public void whenIListMissingFiles() {
    }

    @Then("the only files listed should be: $fileList")
    @Pending
    public void shouldBeListed(List<String> fileList) {
    }
}