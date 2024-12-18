defmodule MbtiBsky.Moonshot do
  @chat_completions_url "https://api.moonshot.cn/v1/chat/completions"

  def chat_completion(request) do
    Req.post(@chat_completions_url,
      json: set_stream(request, false),
      auth: {:bearer, api_key()},
      receive_timeout: 600_000,
      connect_options: [protocols: [:http1]]
    )
  end

  defp set_stream(request, value) do
    request
    |> Map.drop([:stream, "stream"])
    |> Map.put(:stream, value)
  end

  defp api_key() do
    System.get_env("OPENAI_API_KEY")
  end

  def parse_chat(%{"choices" => [%{"message" => %{"content" => content}} | _]}) do
    {:ok, content}
  end

  def parse_chat(error) do
    error
  end
end
