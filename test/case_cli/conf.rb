class TestColorEcho < Minitest::Test
    def test_cli_conf_join
        dir  = ENV["HOME"] + "/.colorecho"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf dir + "/default", <<-EOS
stripe
fg=yellow
        EOS

        cmd = %(colorecho -e "Color\nEcho\nColor\nEcho\nColor\nEcho")
        history cmd
        puts `#{cmd}`
        info %(expect: yellow and white stripe)
    end

    # Usually case
    def test_cli_conf_combination
        dir  = ENV["HOME"] + "/.colorecho"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf dir + "/default", <<-EOS
f=red
        EOS

        write_conf dir + "/foo", <<-EOS
b=index139
        EOS

        write_conf dir + "/bar", <<-EOS
t=underline
        EOS

        cmd = %(colorecho -c foo,bar "Color Echo")
        history cmd
        puts `#{cmd}`

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf dir + "/foo", <<-EOS
p=2,h_yellow,nil,bold,underline
        EOS

        write_conf dir + "/bar", <<-EOS
f=gray
        EOS

        cmd = %(colorecho -c foo,bar -H blue "Color Echo1\nColor Echo2\nColor Echo3")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_conf_priority
        dir  = ENV["HOME"] + "/.colorecho"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf dir + "/default", <<-EOS
f=green
        EOS

        write_conf dir + "/foo", <<-EOS
f=cyan
        EOS

        write_conf dir + "/bar", <<-EOS
f=yellow
        EOS

        cmd = %(colorecho "Color Echo")
        history cmd
        info %(Will be green.)
        puts `#{cmd}`

        cmd = %(colorecho "Color Echo" -f red)
        history cmd
        info %(Will be red.)
        puts `#{cmd}`

        cmd = %(colorecho -c foo "Color Echo")
        history cmd
        info %(Will be cyan.)
        puts `#{cmd}`

        cmd = %(colorecho -c foo,bar "Color Echo")
        history cmd
        info %(Will be yellow.)
        puts `#{cmd}`

        cmd = %(colorecho -c bar,foo "Color Echo")
        history cmd
        info %(Will be cyan.)
        puts `#{cmd}`

        cmd = %(colorecho -c bar,foo -f red "Color Echo")
        history cmd
        info %(Will be red.)
        puts `#{cmd}`
    end

    def test_cli_conf_use_env
        history %(Do -> export COLORECHO=/path/to/dir and generate option's file, and then use it by -c option.) 
    end

    def test_cli_conf_default
        dir  = ENV["HOME"] + "/.colorecho"
        path = dir + "/default"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf path, <<-EOS
# this is comment
--fg=h_yellow
--tx=underline,bold
        EOS

        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho "Color Echo" -c default)
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
fg=white
bg=green
tx=bold
        EOS

        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_conf_all_option
        dir  = ENV["HOME"] + "/.colorecho"
        path = dir + "/default"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf path, <<-EOS
fg=h_yellow
bg=blue
tx=underline
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
-n
        EOS
        cmd = %(colorecho "Color Echo" | colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
e
        EOS
        cmd = %(colorecho "Color\nEcho\nColor\nEcho\nColor\nEcho")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
--stripe
        EOS
        cmd = %(colorecho "Color\nEcho\nColor\nEcho\nColor\nEcho")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
p=Ec
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
pickup=2,red,nil,bold,underline
H=index55,nil,bold
        EOS
        cmd = %(colorecho "Color1\nEcho1\nColor2\nEcho2\nColor3\nEcho3")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
        EOS
        msg  = %(\n\033[31mColorEcho\033[0m)
        msg += %(\n\033[31mColorEcho\033[0m)
        msg += %(\n\033[31mColorEcho\033[0m)
        cmd = %(colorecho -e "#{msg}")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
f=yellow
        EOS
        msg  = %(\n\033[31mColorEcho\033[0m)
        msg += %(\n\033[31mColorEcho\033[0m)
        msg += %(\n\033[31mColorEcho\033[0m)
        cmd = %(colorecho -e "#{msg}")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
f=yellow
R
        EOS
        msg  = %(\n\033[31mColorEcho\033[0m)
        msg += %(\n\033[31mColorEcho\033[0m)
        msg += %(\n\033[31mColorEcho\033[0m)
        cmd = %(colorecho -e "#{msg}")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
p=/Echo1/
r
        EOS
        msg  = %(\n\033[31mColorEcho1\033[0m)
        msg += %(\n\033[31mColorEcho2\033[0m)
        msg += %(\n\033[31mColorEcho3\033[0m)
        cmd = %(colorecho -e "#{msg}")
        history cmd
        puts `#{cmd}`

        info %(Write 'w' to .colorecho/default and execute as tailf /path/to/file | colorecho)
    end

    # Exception case
    def test_cli_conf_error_nodir
        dir = ENV["HOME"] + "/.colorecho"

        delete_target(dir)

        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -c foo "Color Echo")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_conf_error_dir_is_file
        dir = ENV["HOME"] + "/.colorecho"

        delete_target(dir)
        File.open(dir, "a+") do |f|
            f.puts("test")
        end
        info %(Generated file -> #{dir})

        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -c foo "Color Echo")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_conf_error_file_is_dir
        dir  = ENV["HOME"] + "/.colorecho"
        path = dir + "/foo"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})
        Dir.mkdir(path)
        info %(Generated directory -> #{path})

        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -c foo "Color Echo")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_conf_error_nofile
        dir  = ENV["HOME"] + "/.colorecho"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        cmd = %(colorecho -c foo "Color Echo")
        history cmd
        puts `#{cmd}`
    end

    def test_cli_conf_error_invalid_options
        dir  = ENV["HOME"] + "/.colorecho"
        path = dir + "/default"

        delete_target(dir)
        Dir.mkdir(dir)
        info %(Generated directory -> #{dir})

        write_conf path, <<-EOS
xxxxxxxxxxxxxxxxxxxxxxx
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
foo=foo
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
fg
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
fg==red
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
--index-list
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
--symbol-list
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
-c=foo
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
-h
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`

        write_conf path, <<-EOS
-v
        EOS
        cmd = %(colorecho "Color Echo")
        history cmd
        puts `#{cmd}`
    end

    private
    def write_conf(path, content)
        content.strip!
        File.open(path, "w+") do |f|
            f.puts content
        end
        info %(Generated file -> #{path})
        info "content as below:"
        puts <<-EOS
--------------------------------------------
#{content}
--------------------------------------------
        EOS
    end

    private
    def delete_target(path)
        return false if !FileTest.exists?(path)

        type = FileTest.directory?(path) ? "directory" : "file"
        #info %(I've found #{type} #{path})
        #warn %(You want to delete it?[y/N])

        #answer = gets.strip
        #if answer != "y"
        #    raise RuntimeError, %(You must delete it. Test Failed!)
        #end

        begin
            if FileTest.directory?(path)
                require "fileutils"
                FileUtils.rm_r(path)
                info %(Deleted directory -> #{path})
            else
                File.delete(path)
                info %(Deleted file -> #{path})
            end
        rescue
            raise RuntimeError, %(Couldn't delete #{path})
        end
    end
end
