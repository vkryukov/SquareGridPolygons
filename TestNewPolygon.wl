(* ::Package:: *)

Needs["NewPolygon`"]


(* ::Subsubsection:: *)
(*polygonWithMidPoints*)


TestCreate[
	NewPolygon`Private`cyclicalPairs @ Range[5],
	{{1,2},{2,3},{3,4},{4,5},{5,1}}
]


TestCreate[
	NewPolygon`Private`polygonWithMidPoints[ {{0,0},{1,0},{1,1},{0,1}} ],
	{{0,0},{1/2,0},{1,0},{1,1/2},{1,1},{1/2,1},{0,1},{0,1/2}}
];


TestCreate[
	NewPolygon`Private`polygonWithMidPoints[{{0,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}}],
	{{0,0},{3,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,5/2},{8,3},{7,3},{7,4},{4,4},{1,4},{1,7/2},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1},{0,1/2}}
];
