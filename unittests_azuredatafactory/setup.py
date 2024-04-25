# install https://dotnet.microsoft.com/en-us/download/dotnet/8.0 runtime, not sdk
# https://github.com/microsoft/data-factory-testing-framework

from data_factory_testing_framework import TestFramework, TestFrameworkType
from data_factory_testing_framework.state import PipelineRunState, RunParameter, RunParameterType, PipelineRunVariable

test_framework = TestFramework(
        framework_type=TestFrameworkType.DataFactory,
        root_folder_path='C:/Users/uanglerm/GitHub/Terraform_Azure_DataStack/unittests_azuredatafactory',
    )


# Arrange
pipeline = test_framework.get_pipeline_by_name("Bulk Copy from Files to Database")
activity = pipeline.get_activity_by_name("Get Files")

state = PipelineRunState(
    parameters=[
        RunParameter(RunParameterType.Pipeline, "SourceContainer", "unittests-azuredatafactory"),
        RunParameter(RunParameterType.Pipeline, "SourceDirectory", "Bulk_Copy_from_Files_to_Database_source"),
    ])
    # variables=[
    #     PipelineRunVariable("JobName", "Job-123"),
    # ])

# Act
activity.evaluate(state)

# # Assert
assert "unittests-azuredatafactory" == activity.type_properties["dataset"]['parameters']['SourceContainer'].result