class NodeJsExecutorService
  PODMAN_IMAGE = "node-eval-app"
  TIMEOUT_SECONDS = 6

  SECCOMP_PATH = Rails.root.join('config', 'container', 'seccomp.json')

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
            "--cap-drop=ALL",
            "--read-only",
            "--network=none",
            "--security-opt", "seccomp=#{SECCOMP_PATH}",           
            "--security-opt=no-new-privileges",
            "--env", "NODE_OPTIONS=--unhandled-rejections=strict",
            "--user", "65534:65534",
            PODMAN_IMAGE
      ]
    begin
      output = ""
      IO.popen(command, "r+", err: [:child, :out]) do |io|
        io.write(js_code)
        io.close_write

        status = nil
        timeout_thread = Thread.new do
          sleep TIMEOUT_SECONDS
          Process.kill("KILL", io.pid) rescue nil
        end

        output = io.read
        timeout_thread.kill
        _, status = Process.wait2(io.pid)

        if status.success?
          Result.success(output.strip)
        else
          Result.error(output.strip)
        end
      end
    rescue => e
      Result.error("Unexpected error: #{e.message}")
    end
  end
end
