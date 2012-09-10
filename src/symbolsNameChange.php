<?php
$file=$argv[1];
$dir=$argv[2];
$d=new DOMDocument();
$d->load($file);
$xp=new DOMXPath($d);
$nodes=$xp->query('/swf/Header/tags/SymbolClass/symbols/Symbol');
foreach($nodes as $node){
	$srcFn=$dir.'/'.$node->getAttribute('objectID').'.swf';
	$dstFn=$dir.'/'.$node->getAttribute('name').'-'.$node->getAttribute('objectID').'.swf';
	if(is_file($srcFn)){
		rename($srcFn,$dstFn);
		echo "rename({$srcFn},{$dstFn});";
	}
}
?>