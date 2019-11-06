class RecheckCli < Formula
  desc "Command-line interface for recheck"
  homepage "https://retest.de/"
  url "https://github.com/retest/recheck.cli/releases/download/v1.6.0/recheck.cli-1.6.0-bin.zip"
  sha256 "9c84a017dd62dbc1f4775af30b24f2cc4dd52bbb587b5fed785d86ef762f75c6"

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    # Install required content.
    libexec.install "lib/"
    # Create simplified launch script.
    (bin/"recheck").write <<~EOS
      #!/usr/bin/env bash
      set -o nounset -o errexit -o pipefail

      # recheck.cli installation directory.
      RECHECK_HOME=#{libexec}

      JAVA="java"

      JAVA_ARGS=(-XX:+HeapDumpOnOutOfMemoryError)
      JAVA_ARGS+=(-XX:-OmitStackTraceInFastThrow)

      exec $JAVA "${JAVA_ARGS[@]}" -jar "$RECHECK_HOME/lib/recheck.cli.jar" "$@" 2>&1
    EOS
  end

  def caveats
    <<~EOS
      You can obtain an auto-completion script for Bash and ZSH via the completion command.
      Simply add the resulting output to your .bash_profile and/or .bashrc, for example:
        $ echo "source <(recheck completion)" >> ~/.bash_profile
      Please note that this requires Bash version 4+ (macOS currently comes with version 3).
    EOS
  end

  test do
    out = shell_output("#{bin}/recheck")
    assert_match "recheck [--help] [--version] [COMMAND]", out
  end
end
