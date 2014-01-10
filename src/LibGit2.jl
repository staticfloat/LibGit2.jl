module LibGit2

include("api.jl")
export api

include("error.jl")
include("types.jl")
include("oid.jl")
include("config.jl")
include("object.jl")
include("tree.jl")
include("index.jl")
include("signature.jl")
include("commit.jl")
include("tag.jl")
include("blob.jl")
include("reference.jl")
include("odb.jl")
include("branch.jl")
include("note.jl")
include("remote.jl")
include("repository.jl")
include("diff.jl")
include("patch.jl")
include("walk.jl")

type __GitThreadsHandle
    
    function __GitThreadsHandle()
        h = new()
        finalizer(h, x -> api.git_threads_shutdown())
        return h
    end
end

const __threads_handle = begin
    api.git_threads_init()
    __GitThreadsHandle()
end

end # module
