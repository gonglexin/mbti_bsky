defmodule MbtiBsky.Ai do
  alias MbtiBsky.Moonshot

  def analyse(tweets, model \\ "moonshot-v1-32k") do
    system_prompt = """
    You are an MBTI expert responsible for determining a user's MBTI type based on their tweets.

    Use the following JSON format to output your reply:

    {
        "type": "MBTI type",
        "reason": "Why you give that result type, you can quote some user's tweets as example."
    }
    """

    request =
      %{
        model: model,
        response_format: %{type: "json_object"},
        temperature: 0.2,
        messages: [
          %{role: "system", content: system_prompt},
          %{role: "user", content: tweets}
        ]
      }

    case Moonshot.chat_completion(request) do
      {:ok, response} ->
        {:ok, content} = Moonshot.parse_chat(response.body)
        JSON.decode(content)

      {:error, e} ->
        {:error, e}
    end
  end
end
