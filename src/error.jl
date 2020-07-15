primitive type Code 32 end

Code(x::Integer) = reinterpret(Code, convert(UInt32, x))
Base.UInt32(x::Code) = reinterpret(UInt32, x)

Base.show(io::IO, c::Code) = print(io, UInt32(c))
Base.print(io::IO, c::Code) = print(io, UInt32(c))

Base.isless(i::Real, c::Code) = (UInt32(c) > i)
Base.isless(c::Code, i::Real) = (UInt32(c) < i)

macro name(c)
	string(c)
end

const OK = Code(0)
export OK

const Canceled = Code(1)
export Canceled

const Unknown = Code(2)
export Unknown

const InvalidArgument = Code(3)
export InvalidArgument

const DeadlineExceeded = Code(4)
export DeadlineExceeded

const NotFound = Code(5)
export NotFound

const AlreadyExists = Code(6)
export AlreadyExists

const PermissionDenied = Code(7)
export PermissionDenied

const ResourceExhausted = Code(8)
export ResourceExhausted

const FailedPrecondition = Code(9)
export FailedPrecondition

const Aborted = Code(10)
export Aborted

const OutOfRange = Code(11)
export OutOfRange

const Unimplemented = Code(12)
export Unimplemented

const Internal = Code(13)
export Internal

const Unavailable = Code(14)
export Unavailable

const DataLoss = Code(15)
export DataLoss

const Unauthenticated = Code(16)
export Unauthenticated

struct gRPCException <: Exception
	code::Code
	message::String

	gRPCException(code::Code, message::String) = begin
		if code > 16 || code < 0
			code = Unknown
		end
		new(code, message)
	end
end

gRPCException(;code::Code, message::String) = gRPCException(code, message)
gRPCException(message::String) = gRPCException(Internal, message)

wrap(ex::gRPCException) = ex
wrap(ex::Exception) = gRPCException(string(ex))
