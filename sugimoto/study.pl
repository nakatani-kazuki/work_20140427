#!/usr/local/bin/perl
use strict;

#1
#print "Hello world!", "\n";

#$ans1 = 123 * 456;
#print '123×456=', "$ans1", "\n";
#直接計算させる方法なかったっけ？

#2
# $x = 86400;
# $y = 365;
# $z = $x * $y;
# print "$z", "\n";

# $x = 10;
# $y = 5;
# $x = $x + $y;
# print "$x", "\n";

#3
#@array = ("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
#print "$array[2]", "\n";

#4
#$str = "a, b, c, d, e";
#@array = split (/, /, $str);
	# split (/区切る基準となる文字とか（今回はカンマ）/, $対象文字とか変数とか)
#print $array[2], "\n";

#5-1
#$x = 1;
#while($x < 5){
#	print "Hello!\n";
#	print "Variable is now $x\n";
#	$x ++;
#}

#$x = 2;
#while ($x < 14){
#	print "there are ". "$x". " sheep.\n";
#	$x += 2; #二項代入演算子というらしい
#}

#my $x = 1;
#while($x < 100000){
#	print "$x\n";
#	$x *= 2;
#}

#5-2
	#↓初期化　　　　　　　　　　；↓「いつまで」の条件　；↓	加える処理
#for( my($i, $j) = (0,0); $i <= 10; $i++, $j = $i*$i ){
#	print "$i\t$j\n";
#	#       ↑\t でタブを挿入
#}

#for(my $x = 100; $x > 1; $x -=1){
#	print"$x\n"
#}

#5-3
#foreach my $i(0..100){
#	my $j = $i*$i;
#	print "$i\t". "$j\n";
#}

#my @array = ("月", "火", "水", "木", "金", "土", "日");
# foreach my $i(1..30){
#	my $j = $i%7-1;
#	print "$i\t$array[$j]\n";
#}

#6
#my %nucleotide = (
#	"a" =>"adenine",
#	"t" =>"thymine",
#	"c" =>"cytosine",
#	"g" =>"guanine"
#);
#print "$nucleotide{c}\n";
#foreach my $key (keys(%nucleotide)){
#	my $value = $nucleotide{$key};
#print "$key","→","$value\n";
#}
#　↑keys関数というらしい。ハッシュに含まれてるすべてのキーをリストで返してくれる。ただし順番は制御できない。

#my %sweets = (
#	"c" => "chocolate",
#	"i" => "icecream",
#	"m" => "macaron",
#	"p" => "pudding"
#	);

#my @keys = keys %sweets; #キーの一覧を取得できる
#my @values = values %sweets; #値の一覧を取得できる
#とりあえずキーと値を別々にリストにして取り出してみることにした
#print "$keys[1]=", "$values[1]\n";
#print "$keys[2]=", "$values[2]\n";

#↓動的なハッシュ作成
#my %nucleotide = (
#	"a" =>"adenine",
#	"t" =>"thymine",
#	"c" =>"cytosine",
#	"g" =>"guanine"
#);
#$nucleotide{u} = "uracil"; #uのキーと値を追加
#print "$nucleotide{u}\n";
#print "$nucleotide{a}\n";

#my %sweets = (
#	"c" => "chocolate",
#	"i" => "icecream",
#	"m" => "macaron",
#	"p" => "pudding"
#	);
#$sweets{h} = "honey";
#print "$sweets{h}\n";


#keys関数ここでやるやつだった
#my %sweets = (
#	"c" => "chocolate",
#	"i" => "icecream",
#	"m" => "macaron",
#	"p" => "pudding"
#	);
#foreach my $key(keys %sweets){
#	print "$key\t","$sweets{$key}\n"; #←キーの文字列と、そのキーの値｛｝を表示
#}
#やっぱり順番は制御できない

#each関数＋while
#my %sweets = (
#	"c" => "chocolate",
#	"i" => "icecream",
#	"m" => "macaron",
#	"p" => "pudding"
#	);

#while((my $key, my $value) = each %sweets){ #←ここで「ハッシュのひとつひとつのキーとバリューにそれぞれ●してね、という命令になってる
#print "$key\t","$value\n";
#}

#hashを使ってまとめる／数える
#my %uniq;
#my @array = (2,3,6,4,8,3,7,9,4,6,8,3,4,6,4,5,8,"papa", "mama", "papa", "Mama");

#foreach my $item(@array){
#	$uniq{$item}=1;
#}
# ★uniqって自分でつける変数名？それともこの変数名を使うとこういう機能が使えるのか？
# arayの中にあるすべての値を"key"化して、値に1を代入している？
# 同じキーに別の値が後から代入されると上書きされる

#my @uniqarray = keys(%uniq);
#print "@uniqarray\n";
#↓確認用
#while((my $key, my $value) = each %uniq){
#	print "$key\t","$value\n";
#}


#hash使って、同じものが何個あるか数える
my $counter = +{};
my @array = (2,3,6,4,8,3,7,9,4,6,8,3,4,6,4,5,8,"papa", "mama", "papa", "Mama");

foreach my $key(@array){
	$counter->{$key}++;
}
#★arayの中の数字をkeyにして、そのkeyにあたると値を＋1していく＝カウントできる

# use Data::Dumper;
# my @aaa = (1,2,3,4,5);
# my @bbb = map { $_ + 1 } @aaa;
# print Dumper(\@bbb);
# package Data::Dumper;
# my ($aaa) = @_;


