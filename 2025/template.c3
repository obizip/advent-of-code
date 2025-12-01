import std::io;

fn long? solve1()
{
	long answer = 1;

	return answer;
}

fn long? solve2()
{
	long answer = 2;

	return answer;
}

fn void main()
{
	@pool()
	{
		io::printfn("Q1: %d", solve1()!!);
		io::printfn("Q2: %d", solve2()!!);
	};
}
