class NodeJsExecutorService
  PODMAN_IMAGE = "node-eval-app"
  TIMEOUT_SECONDS = 6

  def self.execute(js_code)
    return Result.error("No JavaScript code provided") if js_code.blank?

    js_code = js_code.gsub("\n", " ")

    command = [
      "podman", "run",
      "--rm",
      "-i",
      "--memory=64m",
      "--cpus=0.5",
      "--pids-limit=50",
      PODMAN_IMAGE
    ]

    begin
      output, status = Timeout.timeout(TIMEOUT_SECONDS) do
        Open3.capture2e(*command, stdin_data: js_code)
      end
      if status.success?
        Result.success(output.strip)
      else
        Result.error(output.strip)
      end
    rescue Timeout::Error
      Result.error("Execution timed out")
    rescue => e
      Result.error("Unexpected error: #{e.message}")
    end
  end
end
