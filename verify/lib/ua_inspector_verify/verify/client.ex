defmodule UAInspectorVerify.Verify.Client do
  @moduledoc false

  def verify(
        %{
          user_agent:
            "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 10.0; Win64; x64; Anonymisiert durch AlMiSoft Browser-Maulkorb 39663422; Trident/7.0; .NET4.0C; .NET4.0E; .NET CLR 2.0.50727; .NET CLR 3.0.30729; .NET CLR 3.5.30729; Tablet PC 2.0; Browzar)"
        },
        _result
      ) do
    # requires mobile app parsing to be skipped
    # fixture is pure browser parser result
    true
  end

  def verify(%{client: testcase}, result) do
    testcase.name == result.name &&
      testcase.type == result.type &&
      testcase.version == result.version
  end
end
