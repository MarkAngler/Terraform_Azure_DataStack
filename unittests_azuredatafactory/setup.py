# install https://dotnet.microsoft.com/en-us/download/dotnet/8.0 runtime, not sdk

from data_factory_testing_framework import TestFramework

test_framework = TestFramework(
        framework_type=TestFrameworkType.DataFactory,
        root_folder_path='/factory',
    )