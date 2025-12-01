import std::io, std::io::file, std::collections::list;

fn long? solve1(List{String} lines)
{
	long ans = 0;
	return ans;
}

fn long? solve2(List{String} lines)
{
	long ans = 0;
	return ans;
}

fn void main()
{
	@pool()
	{
		File f = file::open("input/inputXX-test.txt", "rb")!!;
		// File f = file::open("input/inputXX.txt", "rb")!!;
		defer (void)f.close();

		List{String} lines;
		while (try line = io::treadline(&f)) lines.push(line);

		io::printfn("Q1: %d", solve1(lines)!!);
		io::printfn("Q2: %d", solve2(lines)!!);
	};
}
