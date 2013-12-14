export GitObject, GitAny, libgit_const, oid, hex

abstract GitObject
type GitAny <: GitObject end
type GitCommit <: GitObject end
type GitTag <: GitObject end

git_otype(::Type{GitAny}) = api.OBJ_ANY
git_otype(::Type{GitCommit}) = api.OBJ_COMMIT
git_otype(::Type{GitTag}) = api.OBJ_TAG 
git_otype{T<:GitObject}(o::T) = git_otype(T)

free!(o::GitObject) = begin
    if o.ptr != C_NULL
        @check api.git_object_free(o.ptr)
        o.ptr = C_NULL
    end
end

Base.isequal(o1::GitObject, o2::GitObject) = begin
    o1.ptr == o2.ptr 
end

function oid(o::GitObject)
    oid_ptr::Ptr{Uint8} = api.git_object_id(o.ptr)
    if oid_ptr == C_NULL
        error("oid pointer is NULL")
    end
    return Oid(oid_ptr)
end

function hex(o::GitObject)
    oid_ptr::Ptr{Uint8} = api.git_object_id(o.ptr)
    if oid_ptr == C_NULL
        error("oid pointer is NULL")
    end
    hex_buff = Array(Uint8, api.OID_HEXSZ)
    @check api.git_oid_fmt(hex_buff, oid_ptr)
    return bytestring(hex_buff)
end

function raw(o::GitObject)
end
