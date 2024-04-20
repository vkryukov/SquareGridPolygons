(* ::Package:: *)

Needs["NewPolygon`"]


Begin["`NewPolygonTests`"]


(* ::Subsubsection:: *)
(*cyclicalPairs*)


TestCreate[
	NewPolygon`Private`cyclicalPairs @ Range[5],
	{{1,2},{2,3},{3,4},{4,5},{5,1}}
]


(* ::Subsubsection:: *)
(*polygonWithMidPoints*)


TestCreate[
	NewPolygon`Private`orderedPolygonAngle[{{0,0},{5,0},{5,-2},{6,-2},{6,-7},{4,-7},{4,-4},{0,-4}}],
	{\[Pi]/2,\[Pi]/2,(3 \[Pi])/2,\[Pi]/2,\[Pi]/2,\[Pi]/2,(3 \[Pi])/2,\[Pi]/2}
]


TestCreate[
	NewPolygon`Private`polygonWithMidPoints[ {{0,0},{1,0},{1,1},{0,1}} ],
	{{0,0},{1,0},{1,1},{0,1}}
];


TestCreate[
	NewPolygon`Private`polygonWithMidPoints[ {{0,0},{2,0},{2,2},{0,2}} ],
	{{0,0},{1,0},{2,0},{2,1},{2,2},{1,2},{0,2},{0,1}}
];


TestCreate[
	NewPolygon`Private`polygonWithMidPoints[{{0,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}}],
	{{0,0},{3,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}}
];


(* ::Subsubsection:: *)
(*rotate90*)


TestCreate[
	NewPolygon`Private`rotate90left /@ {{1, 0}, {0, 1}, {-1, 0}, {0, -1}},
	RotateLeft[ {{1, 0}, {0, 1}, {-1, 0}, {0, -1}}, 1]
];


TestCreate[
	NewPolygon`Private`rotate90right /@ {{1, 0}, {0, 1}, {-1, 0}, {0, -1}},
	RotateRight[ {{1, 0}, {0, 1}, {-1, 0}, {0, -1}}, 1]
];


TestCreate[
	(NewPolygon`Private`rotate90left @ NewPolygon`Private`rotate90right @ #)& /@ {
		{1, 0}, {0, 1}, {-1, 0}, {0, -1}},
	{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
]


TestCreate[
	(NewPolygon`Private`rotate90right @ NewPolygon`Private`rotate90left @ #)& /@ 
		{{1, 0}, {0, 1}, {-1, 0}, {0, -1}},
	{{1, 0}, {0, 1}, {-1, 0}, {0, -1}}
]


(* ::Subsubsection:: *)
(*add*)


TestCreate[
	Table[
		NewPolygon`Private`add[ x[[1]], x[[2]], x[[3]]],
		{x, {{18, 5, 10}, {18, 5, 13}, {18, 5, 15}, 
			 {5, 5, -5}, {5, 3, -1}, {10,2,-9}}}
	], 
	{15, 18, 2, 
	 5, 2, 3}
]; 


(* ::Subsubsection:: *)
(*orientedSides*)


TestCreate[
	With[{poly={{0,0},{5,0},{5,-2},{6,-2},{6,-7},{4,-7},{4,-4},{0,-4}}},
		{NewPolygon`Private`orientedSides[poly,True],
		NewPolygon`Private`orientedSides[poly,False],
		NewPolygon`Private`orientedSides[Reverse@poly,True],
		NewPolygon`Private`orientedSides[Reverse@poly,True],
		NewPolygon`Private`orientedSides[RotateLeft[poly,3],True],
		NewPolygon`Private`orientedSides[RotateRight[poly,2],True]}],
	{
		{{{1,0},{0,1}},{{0,-1},{1,0}},{{1,0},{0,1}},{{0,-1},{1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}}},
		{{{0,-1},{-1,0}},{{-1,0},{0,1}},{{0,1},{1,0}},{{-1,0},{0,1}},{{0,1},{1,0}},{{1,0},{0,-1}},{{0,-1},{-1,0}},{{1,0},{0,-1}}},
		{{{0,1},{-1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{-1,0},{0,-1}},{{0,-1},{1,0}},{{1,0},{0,1}},{{0,-1},{1,0}},{{1,0},{0,1}}},
		{{{0,1},{-1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{-1,0},{0,-1}},{{0,-1},{1,0}},{{1,0},{0,1}},{{0,-1},{1,0}},{{1,0},{0,1}}},
		{{{0,-1},{1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{1,0},{0,1}},{{0,-1},{1,0}},{{1,0},{0,1}}},
		{{{-1,0},{0,-1}},{{0,1},{-1,0}},{{1,0},{0,1}},{{0,-1},{1,0}},{{1,0},{0,1}},{{0,-1},{1,0}},{{-1,0},{0,-1}},{{0,1},{-1,0}}}}
];


Module[ {
	crossPolygon = {
	{1,1},{1,2},{1,3},{0,3},{-1,3},{-1,2},{-1,1},
	{-2,1},{-3,1},{-3,0},{-3,-1},{-2,-1},{-1,-1},
	{-1,-2},{-1,-3},{0,-3},{1,-3},{1,-2},{1,-1},
	{2,-1},{3,-1},{3,0},{3,1},{2,1}
	},
	
	fn, f
	},
	
TestCreate[
	NewPolygon`Private`orientedSides[crossPolygon],
	{{{0,1},{1,0}},{{0,1},{1,0}},{{-1,0},{0,1}},{{-1,0},{0,1}},{{0,-1},{-1,0}},{{0,-1},{-1,0}},{{-1,0},{0,1}},{{-1,0},{0,1}},{{0,-1},{-1,0}},{{0,-1},{-1,0}},{{1,0},{0,-1}},{{1,0},{0,-1}},{{0,-1},{-1,0}},{{0,-1},{-1,0}},{{1,0},{0,-1}},{{1,0},{0,-1}},{{0,1},{1,0}},{{0,1},{1,0}},{{1,0},{0,-1}},{{1,0},{0,-1}},{{0,1},{1,0}},{{0,1},{1,0}},{{-1,0},{0,1}},{{-1,0},{0,1}}}
];

TestCreate[
	NewPolygon`Private`orientedSides[Reverse@RotateLeft[crossPolygon,7]],
	{{{0,1},{-1,0}},{{0,1},{-1,0}},{{1,0},{0,1}},{{1,0},{0,1}},{{0,-1},{1,0}},{{0,-1},{1,0}},{{1,0},{0,1}},{{1,0},{0,1}},{{0,-1},{1,0}},{{0,-1},{1,0}},{{-1,0},{0,-1}},{{-1,0},{0,-1}},{{0,-1},{1,0}},{{0,-1},{1,0}},{{-1,0},{0,-1}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{0,1},{-1,0}},{{-1,0},{0,-1}},{{-1,0},{0,-1}},{{0,1},{-1,0}},{{0,1},{-1,0}},{{1,0},{0,1}},{{1,0},{0,1}}}
];

	fn = NewPolygon`Private`directionTester[ crossPolygon ];
	f[i_]:=fn[i,#,True]&/@{{0,1},{1,0},{0,-1},{-1,0}};

TestCreate[
	Evaluate[f/@Range[24]],
	{{0,0,-1,-1},{0,1,0,-1},{1,1,0,0},{1,0,-1,0},{1,0,0,1},{0,-1,0,1},{0,-1,-1,0},{1,0,-1,0},{1,0,0,1},{0,-1,0,1},{0,0,1,1},{-1,0,1,0},{-1,-1,0,0},{0,-1,0,1},{0,0,1,1},{-1,0,1,0},{0,1,1,0},{0,1,0,-1},{-1,0,0,-1},{-1,0,1,0},{0,1,1,0},{0,1,0,-1},{1,1,0,0},{1,0,-1,0}}
];

	f[i_]:=fn[i,#,False]&/@{{0,1},{1,0},{0,-1},{-1,0}};

TestCreate[
	Evaluate[f/@Range[24]],
	{{0,1,0,-1},{0,1,0,-1},{1,0,-1,0},{1,0,-1,0},{0,-1,0,1},{0,-1,0,1},{1,0,-1,0},{1,0,-1,0},{0,-1,0,1},{0,-1,0,1},{-1,0,1,0},{-1,0,1,0},{0,-1,0,1},{0,-1,0,1},{-1,0,1,0},{-1,0,1,0},{0,1,0,-1},{0,1,0,-1},{-1,0,1,0},{-1,0,1,0},{0,1,0,-1},{0,1,0,-1},{1,0,-1,0},{1,0,-1,0}},
	TestID->"directionTester[crossPolygon][_,_,True]"
]; 

	fn = NewPolygon`Private`directionTester[ Reverse@RotateLeft[crossPolygon,7] ];
	f[i_]:=fn[i,#,True]&/@{{0,1},{1,0},{0,-1},{-1,0}};
	
TestCreate[
	Evaluate[f/@Range[24]],
	{{0,-1,-1,0},{0,-1,0,1},{1,0,0,1},{1,0,-1,0},{1,1,0,0},{0,1,0,-1},{0,0,-1,-1},{1,0,-1,0},{1,1,0,0},{0,1,0,-1},{0,1,1,0},{-1,0,1,0},{-1,0,0,-1},{0,1,0,-1},{0,1,1,0},{-1,0,1,0},{0,0,1,1},{0,-1,0,1},{-1,-1,0,0},{-1,0,1,0},{0,0,1,1},{0,-1,0,1},{1,0,0,1},{1,0,-1,0}}
];
		
];


(* ::Subsubsection:: *)
(*Tests for findSameDirectionsCandidatesNew*)


(* ::Text:: *)
(*Making sure that it doesn't change during the refactoring.*)


TestCreate[
	NewPolygon`Private`findSameDirectionCandidatesNew[{{0,0},{5,0},{5,-2},{6,-2},{6,-7},{4,-7},{4,-4},{0,-4}}],
	{{1,2,-1,{{{0,0},{0,-2},{0,-4},{4,-4}},{{5,0},{3,0},{1,0},{1,-4}},8}},{1,4,-1,{{{0,0},{0,-2},{0,-4},{4,-4}},{{6,-2},{5,-2},{4,-2},{2,-2},{2,-4}},8}},{1,5,-1,{{{0,0},{0,-2},{0,-4},{4,-4},{4,-7}},{{6,-7},{6,-5},{6,-3},{2,-3},{2,0}},1}},{1,7,1,{{{0,0},{5,0},{5,-2}},{{4,-7},{4,-4},{4,-2},{5,-2}},2}},{2,4,-1,{{{5,0},{0,0},{0,-2}},{{6,-2},{5,-2},{1,-2},{1,-4}},8}},{2,5,-1,{{{5,0},{0,0},{0,-2},{0,-4},{4,-4}},{{6,-7},{6,-2},{5,-2},{4,-2},{2,-2},{2,-4}},8}},{2,9,-1,{{{5,0},{0,0},{0,-2}},{{0,-4},{4,-4},{5,-4},{5,-2}},2}},{3,1,1,{{{5,-2},{6,-2},{6,-7}},{{0,0},{1,0},{1,-4}},8}},{3,1,-1,{{{5,-2},{5,0},{0,0}},{{0,0},{0,-2},{5,-2}},2}},{3,2,1,{{{5,-2},{6,-2},{6,-7}},{{5,0},{5,-1},{0,-1}},10}},{3,4,-1,{{{5,-2},{5,0},{0,0}},{{6,-2},{5,-2},{4,-2},{4,-4}},7}},{3,5,1,{{{5,-2},{6,-2},{6,-7}},{{6,-7},{5,-7},{5,-2}},2}},{3,5,-1,{{{5,-2},{5,0},{0,0}},{{6,-7},{6,-5},{4,-5}},7}},{3,6,1,{{{5,-2},{6,-2},{6,-7},{5,-7}},{{5,-7},{4,-7},{4,-4},{4,-2},{5,-2}},2}},{3,7,1,{{{5,-2},{6,-2},{6,-7}},{{4,-7},{4,-6},{6,-6}},4}},{3,7,-1,{{{5,-2},{5,0},{0,0},{0,-2},{0,-4},{4,-4}},{{4,-7},{5,-7},{6,-7},{6,-2},{5,-2},{4,-2},{2,-2},{2,-4}},8}},{3,8,1,{{{5,-2},{6,-2},{6,-7}},{{4,-4},{3,-4},{3,0}},1}},{3,8,-1,{{{5,-2},{5,0},{0,0}},{{4,-4},{4,-6},{6,-6}},4}},{3,9,1,{{{5,-2},{6,-2},{6,-7},{5,-7},{4,-7},{4,-4}},{{0,-4},{0,-3},{5,-3},{5,-4},{5,-5},{4,-5}},7}},{3,9,-1,{{{5,-2},{5,0},{0,0}},{{0,-4},{2,-4},{2,0}},1}},{3,10,1,{{{5,-2},{6,-2},{6,-7}},{{0,-2},{0,-1},{5,-1}},2}},{3,10,-1,{{{5,-2},{5,0},{0,0},{0,-2}},{{0,-2},{0,-4},{4,-4},{5,-4},{5,-2}},2}},{4,1,1,{{{6,-2},{6,-7},{5,-7},{4,-7},{4,-4},{0,-4}},{{0,0},{5,0},{5,-1},{5,-2},{2,-2},{2,-4}},8}},{4,2,1,{{{6,-2},{6,-7},{5,-7}},{{5,0},{5,-2},{5,-5},{4,-5}},7}},{4,7,1,{{{6,-2},{6,-7},{5,-7}},{{4,-7},{4,-4},{4,-2},{5,-2}},2}},{5,1,1,{{{6,-7},{5,-7},{4,-7},{4,-4},{0,-4}},{{0,0},{1,0},{2,0},{2,-3},{6,-3}},4}},{5,2,1,{{{6,-7},{5,-7},{4,-7},{4,-4},{0,-4}},{{5,0},{5,-1},{5,-2},{2,-2},{2,-4}},8}},{5,4,1,{{{6,-7},{5,-7},{4,-7},{4,-4}},{{6,-2},{6,-3},{6,-4},{4,-4}},7}},{5,9,1,{{{6,-7},{5,-7},{4,-7},{4,-4},{0,-4}},{{0,-4},{0,-3},{0,-2},{3,-2},{3,0}},1}},{5,9,-1,{{{6,-7},{6,-2},{5,-2},{5,0}},{{0,-4},{4,-4},{5,-4},{5,-3},{6,-3}},4}},{6,1,1,{{{5,-7},{4,-7},{4,-4},{0,-4},{0,-2},{0,0}},{{0,0},{1,0},{1,-3},{5,-3},{5,-5},{5,-7}},5}},{6,1,-1,{{{5,-7},{6,-7},{6,-2}},{{0,0},{0,-1},{5,-1}},2}},{6,2,1,{{{5,-7},{4,-7},{4,-4},{0,-4}},{{5,0},{5,-1},{2,-1},{2,-4}},8}},{6,2,-1,{{{5,-7},{6,-7},{6,-2}},{{5,0},{4,0},{4,-4}},7}},{6,3,-1,{{{5,-7},{6,-7},{6,-2}},{{5,-2},{5,-1},{0,-1}},10}},{6,4,1,{{{5,-7},{4,-7},{4,-4},{0,-4}},{{6,-2},{6,-3},{3,-3},{3,-4}},8}},{6,4,-1,{{{5,-7},{6,-7},{6,-2}},{{6,-2},{5,-2},{5,-7}},5}},{6,5,1,{{{5,-7},{4,-7},{4,-4},{0,-4}},{{6,-7},{5,-7},{5,-4},{4,-4}},7}},{6,7,-1,{{{5,-7},{6,-7},{6,-2}},{{4,-7},{5,-7},{5,-2}},2}},{6,8,-1,{{{5,-7},{6,-7},{6,-2}},{{4,-4},{4,-5},{6,-5}},4}},{6,9,1,{{{5,-7},{4,-7},{4,-4},{0,-4}},{{0,-4},{0,-3},{3,-3},{3,0}},1}},{6,9,-1,{{{5,-7},{6,-7},{6,-2}},{{0,-4},{1,-4},{1,0}},1}},{6,10,1,{{{5,-7},{4,-7},{4,-4},{0,-4}},{{0,-2},{0,-1},{3,-1},{3,0}},1}},{6,10,-1,{{{5,-7},{6,-7},{6,-2},{5,-2}},{{0,-2},{0,-3},{5,-3},{5,-2}},2}},{7,1,-1,{{{4,-7},{5,-7},{6,-7},{6,-2}},{{0,0},{0,-1},{0,-2},{5,-2}},2}},{7,2,1,{{{4,-7},{4,-4},{0,-4}},{{5,0},{5,-2},{5,-3},{6,-3}},4}},{7,2,-1,{{{4,-7},{5,-7},{6,-7},{6,-2}},{{5,0},{4,0},{3,0},{3,-4}},8}},{7,4,-1,{{{4,-7},{5,-7},{6,-7},{6,-2}},{{6,-2},{5,-2},{4,-2},{4,-4}},7}},{7,8,-1,{{{4,-7},{5,-7},{6,-7},{6,-2}},{{4,-4},{4,-5},{4,-6},{6,-6}},4}},{7,9,-1,{{{4,-7},{5,-7},{6,-7},{6,-2}},{{0,-4},{1,-4},{2,-4},{2,0}},1}},{7,10,-1,{{{4,-7},{5,-7},{6,-7},{6,-2},{5,-2},{5,0}},{{0,-2},{0,-3},{0,-4},{4,-4},{5,-4},{5,-3},{6,-3}},4}},{8,1,1,{{{4,-4},{0,-4},{0,-2},{0,0}},{{0,0},{4,0},{4,-2},{4,-4}},7}},{8,1,-1,{{{4,-4},{4,-7},{5,-7},{6,-7},{6,-2}},{{0,0},{0,-2},{0,-3},{1,-3},{2,-3},{2,0}},1}},{8,2,1,{{{4,-4},{0,-4},{0,-2}},{{5,0},{5,-2},{5,-4},{4,-4}},7}},{8,2,-1,{{{4,-4},{4,-7},{5,-7},{6,-7},{6,-2}},{{5,0},{2,0},{2,-1},{2,-2},{5,-2}},2}},{8,4,1,{{{4,-4},{0,-4},{0,-2}},{{6,-2},{6,-6},{4,-6}},7}},{8,4,-1,{{{4,-4},{4,-7},{5,-7},{6,-7}},{{6,-2},{5,-2},{3,-2},{3,-3},{3,-4}},8}},{8,5,-1,{{{4,-4},{4,-7},{5,-7},{6,-7}},{{6,-7},{6,-4},{5,-4},{4,-4}},7}},{8,7,1,{{{4,-4},{0,-4},{0,-2}},{{4,-7},{4,-4},{4,-3},{6,-3}},4}},{8,9,-1,{{{4,-4},{4,-7},{5,-7},{6,-7},{6,-2}},{{0,-4},{3,-4},{3,-3},{3,-2},{0,-2}},9}},{9,2,1,{{{0,-4},{0,-2},{0,0},{5,0}},{{5,0},{5,-2},{5,-4},{4,-4}},7}},{9,4,1,{{{0,-4},{0,-2},{0,0},{5,0}},{{6,-2},{6,-4},{6,-6},{4,-6}},7}},{9,4,-1,{{{0,-4},{4,-4},{4,-7}},{{6,-2},{5,-2},{2,-2},{2,0}},1}},{9,7,1,{{{0,-4},{0,-2},{0,0},{5,0}},{{4,-7},{4,-5},{4,-4},{4,-3},{6,-3}},4}},{10,1,-1,{{{0,-2},{0,-4},{4,-4},{4,-7}},{{0,0},{0,-2},{4,-2},{4,-4}},7}},{10,2,1,{{{0,-2},{0,0},{5,0}},{{5,0},{5,-2},{0,-2}},9}},{10,2,-1,{{{0,-2},{0,-4},{4,-4}},{{5,0},{3,0},{3,-4}},8}},{10,4,1,{{{0,-2},{0,0},{5,0}},{{6,-2},{6,-4},{4,-4}},7}},{10,4,-1,{{{0,-2},{0,-4},{4,-4}},{{6,-2},{5,-2},{4,-2},{4,-4}},7}},{10,5,1,{{{0,-2},{0,0},{5,0},{5,-2}},{{6,-7},{5,-7},{4,-7},{4,-4},{4,-2},{5,-2}},2}},{10,5,-1,{{{0,-2},{0,-4},{4,-4}},{{6,-7},{6,-5},{4,-5}},7}},{10,7,1,{{{0,-2},{0,0},{5,0}},{{4,-7},{4,-5},{6,-5}},4}},{10,8,1,{{{0,-2},{0,0},{5,0}},{{4,-4},{2,-4},{2,0}},1}},{10,8,-1,{{{0,-2},{0,-4},{4,-4}},{{4,-4},{4,-6},{6,-6}},4}},{10,9,1,{{{0,-2},{0,0},{5,0}},{{0,-4},{0,-2},{5,-2}},2}}}
];


TestCreate[
	NewPolygon`Private`findSameDirectionCandidatesNew[{{0,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}}],
	{{1,2,-1,{{{0,0},{0,1},{1,1},{1,2}},{{3,0},{2,0},{2,1},{1,1}},16}},{1,3,1,{{{0,0},{3,0},{6,0}},{{6,0},{6,1},{6,3},{6,4}},10}},{1,3,-1,{{{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3},{1,4},{4,4}},{{6,0},{5,0},{5,1},{4,1},{4,2},{3,2},{3,1},{2,1},{2,2}},14}},{1,5,1,{{{0,0},{3,0}},{{7,1},{7,2},{7,3}},8}},{1,5,-1,{{{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3},{1,4},{4,4}},{{7,1},{6,1},{6,2},{5,2},{5,3},{4,3},{4,2},{3,2},{3,4}},11}},{1,7,-1,{{{0,0},{0,1},{1,1}},{{8,2},{7,2},{7,3}},8}},{1,8,1,{{{0,0},{3,0},{6,0}},{{8,3},{7,3},{5,3},{2,3}},13}},{1,10,-1,{{{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3}},{{7,4},{7,3},{6,3},{6,2},{5,2},{5,1},{6,1}},3}},{1,11,-1,{{{0,0},{0,1},{1,1},{1,2},{2,2},{2,3}},{{4,4},{5,4},{5,3},{6,3},{6,2},{7,2}},5}},{1,12,-1,{{{0,0},{0,1},{1,1}},{{1,4},{2,4},{2,3}},13}},{1,13,1,{{{0,0},{3,0},{6,0}},{{1,3},{2,3},{4,3},{7,3}},8}},{1,14,1,{{{0,0},{3,0}},{{2,3},{2,2},{2,0}},1}},{1,15,-1,{{{0,0},{0,1},{1,1},{1,2}},{{2,2},{2,3},{3,3},{3,4}},11}},{1,16,1,{{{0,0},{3,0}},{{1,2},{1,1},{1,0}},1}},{2,1,1,{{{3,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4}},{{0,0},{3,0},{3,1},{4,1},{4,2},{5,2},{5,3},{4,3},{4,4}},10}},{2,3,-1,{{{3,0},{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3},{1,4}},{{6,0},{3,0},{3,1},{4,1},{4,2},{5,2},{5,3},{4,3},{4,4}},10}},{2,5,1,{{{3,0},{6,0}},{{7,1},{7,2},{7,3}},8}},{2,5,-1,{{{3,0},{0,0},{0,1},{1,1},{1,2},{2,2},{2,3}},{{7,1},{6,1},{4,1},{4,2},{5,2},{5,3},{6,3},{6,4}},10}},{2,7,-1,{{{3,0},{0,0},{0,1},{1,1},{1,2}},{{8,2},{7,2},{5,2},{5,3},{6,3},{6,4}},10}},{2,8,1,{{{3,0},{6,0},{6,1},{7,1},{7,2},{8,2},{8,3}},{{8,3},{7,3},{5,3},{5,2},{4,2},{4,1},{3,1},{3,0}},1}},{2,10,1,{{{3,0},{6,0},{6,1},{7,1},{7,2},{8,2}},{{7,4},{4,4},{4,3},{3,3},{3,2},{2,2}},14}},{2,10,-1,{{{3,0},{0,0}},{{7,4},{7,3},{7,2}},5}},{2,11,-1,{{{3,0},{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3}},{{4,4},{7,4},{7,3},{6,3},{6,2},{5,2},{5,1},{6,1}},3}},{2,12,-1,{{{3,0},{0,0},{0,1},{1,1},{1,2},{2,2}},{{1,4},{4,4},{4,3},{3,3},{3,2},{2,2}},14}},{2,13,1,{{{3,0},{6,0},{6,1}},{{1,3},{2,3},{4,3},{4,4}},10}},{2,14,1,{{{3,0},{6,0}},{{2,3},{2,2},{2,0}},1}},{2,15,-1,{{{3,0},{0,0}},{{2,2},{2,3},{2,4}},11}},{2,16,1,{{{3,0},{6,0}},{{1,2},{1,1},{1,0}},1}},{2,16,-1,{{{3,0},{0,0},{0,1},{1,1},{1,2}},{{1,2},{2,2},{4,2},{4,1},{3,1},{3,0}},1}},{2,18,-1,{{{3,0},{0,0},{0,1}},{{0,1},{1,1},{3,1},{3,0}},1}},{3,5,-1,{{{6,0},{3,0},{0,0}},{{7,1},{6,1},{4,1},{1,1}},16}},{3,7,-1,{{{6,0},{3,0},{0,0}},{{8,2},{7,2},{5,2},{2,2}},14}},{3,10,-1,{{{6,0},{3,0}},{{7,4},{7,3},{7,2}},5}},{3,12,-1,{{{6,0},{3,0},{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3}},{{1,4},{4,4},{7,4},{7,3},{6,3},{6,2},{5,2},{5,1},{6,1}},3}},{3,13,1,{{{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{1,3},{2,3},{2,2},{3,2},{3,1},{4,1},{4,2},{5,2},{5,4}},10}},{3,15,-1,{{{6,0},{3,0}},{{2,2},{2,3},{2,4}},11}},{3,16,-1,{{{6,0},{3,0},{0,0}},{{1,2},{2,2},{4,2},{7,2}},5}},{3,18,-1,{{{6,0},{3,0},{0,0}},{{0,1},{1,1},{3,1},{6,1}},3}},{4,1,1,{{{6,1},{7,1},{7,2}},{{0,0},{1,0},{1,1}},16}},{4,1,-1,{{{6,1},{6,0},{3,0},{0,0}},{{0,0},{0,1},{1,1},{3,1},{6,1}},3}},{4,2,1,{{{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{3,0},{4,0},{4,1},{5,1},{5,2},{4,2},{4,3},{2,3}},13}},{4,2,-1,{{{6,1},{6,0},{3,0}},{{3,0},{2,0},{2,2}},14}},{4,3,1,{{{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{6,0},{6,1},{5,1},{5,2},{4,2},{4,1},{3,1},{3,0}},1}},{4,5,-1,{{{6,1},{6,0},{3,0}},{{7,1},{6,1},{6,4}},10}},{4,6,-1,{{{6,1},{6,0},{3,0},{0,0}},{{7,2},{7,1},{6,1},{4,1},{1,1}},16}},{4,7,-1,{{{6,1},{6,0},{3,0}},{{8,2},{7,2},{7,3}},8}},{4,8,1,{{{6,1},{7,1},{7,2}},{{8,3},{7,3},{7,2}},5}},{4,8,-1,{{{6,1},{6,0},{3,0},{0,0}},{{8,3},{8,2},{7,2},{5,2},{2,2}},14}},{4,10,1,{{{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4}},{{7,4},{6,4},{6,3},{5,3},{5,2},{6,2},{6,1}},3}},{4,10,-1,{{{6,1},{6,0},{3,0},{0,0}},{{7,4},{7,3},{4,3},{2,3}},13}},{4,11,1,{{{6,1},{7,1},{7,2},{8,2}},{{4,4},{3,4},{3,3},{2,3}},13}},{4,11,-1,{{{6,1},{6,0},{3,0},{0,0}},{{4,4},{5,4},{5,1},{5,0}},2}},{4,12,1,{{{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{1,4},{1,3},{2,3},{2,2},{3,2},{3,3},{4,3},{4,4}},10}},{4,12,-1,{{{6,1},{6,0},{3,0}},{{1,4},{2,4},{2,3}},13}},{4,13,1,{{{6,1},{7,1},{7,2}},{{1,3},{2,3},{2,4}},11}},{4,13,-1,{{{6,1},{6,0},{3,0},{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{1,3}},{{1,3},{1,4},{4,4},{7,4},{7,3},{6,3},{6,2},{5,2},{5,1},{6,1}},3}},{4,14,1,{{{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{2,3},{2,2},{3,2},{3,1},{4,1},{4,2},{5,2},{5,4}},10}},{4,15,-1,{{{6,1},{6,0},{3,0},{0,0}},{{2,2},{2,3},{5,3},{7,3}},8}},{4,16,1,{{{6,1},{7,1},{7,2},{8,2}},{{1,2},{1,1},{2,1},{2,0}},1}},{4,16,-1,{{{6,1},{6,0},{3,0}},{{1,2},{2,2},{2,0}},1}},{4,17,-1,{{{6,1},{6,0},{3,0},{0,0}},{{1,1},{1,2},{2,2},{4,2},{7,2}},5}},{4,18,-1,{{{6,1},{6,0},{3,0}},{{0,1},{1,1},{1,0}},1}},{5,3,1,{{{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4},{1,4}},{{6,0},{6,1},{7,1},{7,2},{6,2},{6,3},{3,3},{2,3}},13}},{5,7,-1,{{{7,1},{6,1},{6,0},{3,0},{0,0}},{{8,2},{7,2},{7,1},{6,1},{4,1},{1,1}},16}},{5,13,1,{{{7,1},{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{1,3},{2,3},{2,2},{3,2},{3,3},{4,3},{4,4}},10}},{5,14,1,{{{7,1},{7,2},{8,2},{8,3},{7,3},{7,4}},{{2,3},{2,2},{1,2},{1,1},{2,1},{2,0}},1}},{5,16,-1,{{{7,1},{6,1},{6,0},{3,0},{0,0}},{{1,2},{2,2},{2,3},{5,3},{7,3}},8}},{5,18,-1,{{{7,1},{6,1},{6,0},{3,0},{0,0}},{{0,1},{1,1},{1,2},{2,2},{4,2},{7,2}},5}},{6,1,1,{{{7,2},{8,2},{8,3}},{{0,0},{1,0},{1,1}},16}},{6,1,-1,{{{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{0,0},{0,1},{1,1},{1,2},{2,2},{4,2},{7,2}},5}},{6,2,1,{{{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{3,0},{4,0},{4,1},{3,1},{3,2},{2,2}},14}},{6,2,-1,{{{7,2},{7,1},{6,1},{6,0}},{{3,0},{2,0},{2,1},{1,1}},16}},{6,3,1,{{{7,2},{8,2},{8,3},{7,3}},{{6,0},{6,1},{5,1},{5,0}},2}},{6,4,1,{{{7,2},{8,2},{8,3},{7,3},{7,4},{4,4},{1,4}},{{6,1},{7,1},{7,2},{6,2},{6,3},{3,3},{2,3}},13}},{6,5,1,{{{7,2},{8,2},{8,3},{7,3}},{{7,1},{7,2},{6,2},{6,1}},3}},{6,7,-1,{{{7,2},{7,1},{6,1}},{{8,2},{7,2},{7,3}},8}},{6,8,1,{{{7,2},{8,2},{8,3}},{{8,3},{7,3},{7,2}},5}},{6,8,-1,{{{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{8,3},{8,2},{7,2},{7,1},{6,1},{4,1},{1,1}},16}},{6,10,1,{{{7,2},{8,2},{8,3},{7,3}},{{7,4},{6,4},{6,3},{7,3}},8}},{6,10,-1,{{{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{7,4},{7,3},{6,3},{6,2},{3,2},{2,2}},14}},{6,11,1,{{{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{4,4},{3,4},{3,3},{4,3},{4,2},{7,2}},5}},{6,11,-1,{{{7,2},{7,1},{6,1},{6,0},{3,0}},{{4,4},{5,4},{5,3},{6,3},{6,1}},3}},{6,12,1,{{{7,2},{8,2},{8,3},{7,3}},{{1,4},{1,3},{2,3},{2,4}},11}},{6,12,-1,{{{7,2},{7,1},{6,1}},{{1,4},{2,4},{2,3}},13}},{6,13,1,{{{7,2},{8,2},{8,3}},{{1,3},{2,3},{2,4}},11}},{6,14,1,{{{7,2},{8,2},{8,3},{7,3},{7,4},{4,4}},{{2,3},{2,2},{3,2},{3,3},{4,3},{4,4}},10}},{6,15,1,{{{7,2},{8,2},{8,3},{7,3},{7,4}},{{2,2},{1,2},{1,1},{2,1},{2,0}},1}},{6,15,-1,{{{7,2},{7,1},{6,1},{6,0}},{{2,2},{2,3},{3,3},{3,4}},11}},{6,16,1,{{{7,2},{8,2},{8,3},{7,3}},{{1,2},{1,1},{2,1},{2,2}},14}},{6,16,-1,{{{7,2},{7,1},{6,1},{6,0},{3,0}},{{1,2},{2,2},{2,1},{3,1},{3,0}},1}},{6,17,-1,{{{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{1,1},{1,2},{2,2},{2,3},{5,3},{7,3}},8}},{6,18,1,{{{7,2},{8,2},{8,3},{7,3}},{{0,1},{0,0},{1,0},{1,1}},16}},{6,18,-1,{{{7,2},{7,1},{6,1}},{{0,1},{1,1},{1,0}},1}},{7,1,1,{{{8,2},{8,3},{7,3}},{{0,0},{1,0},{1,1}},16}},{7,2,1,{{{8,2},{8,3},{7,3},{7,4},{4,4}},{{3,0},{4,0},{4,1},{5,1},{5,4}},10}},{7,3,1,{{{8,2},{8,3},{7,3},{7,4},{4,4}},{{6,0},{6,1},{5,1},{5,2},{2,2}},14}},{7,5,1,{{{8,2},{8,3},{7,3},{7,4},{4,4},{1,4}},{{7,1},{7,2},{6,2},{6,3},{3,3},{2,3}},13}},{7,11,1,{{{8,2},{8,3},{7,3},{7,4}},{{4,4},{3,4},{3,3},{2,3}},13}},{7,12,1,{{{8,2},{8,3},{7,3},{7,4},{4,4},{1,4}},{{1,4},{1,3},{2,3},{2,2},{5,2},{7,2}},5}},{7,13,1,{{{8,2},{8,3},{7,3}},{{1,3},{2,3},{2,4}},11}},{7,14,1,{{{8,2},{8,3},{7,3},{7,4},{4,4}},{{2,3},{2,2},{3,2},{3,1},{6,1}},3}},{7,16,1,{{{8,2},{8,3},{7,3},{7,4}},{{1,2},{1,1},{2,1},{2,0}},1}},{7,16,-1,{{{8,2},{7,2},{7,1},{6,1},{6,0}},{{1,2},{2,2},{2,3},{3,3},{3,4}},11}},{7,18,-1,{{{8,2},{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{0,1},{1,1},{1,2},{2,2},{2,3},{5,3},{7,3}},8}},{8,1,-1,{{{8,3},{8,2},{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{0,0},{0,1},{1,1},{1,2},{2,2},{2,3},{5,3},{7,3}},8}},{8,2,-1,{{{8,3},{8,2},{7,2},{7,1}},{{3,0},{2,0},{2,1},{1,1}},16}},{8,3,1,{{{8,3},{7,3},{7,4},{4,4}},{{6,0},{6,1},{7,1},{7,2},{7,3}},8}},{8,10,-1,{{{8,3},{8,2},{7,2},{7,1},{6,1},{6,0},{3,0},{0,0}},{{7,4},{7,3},{6,3},{6,2},{5,2},{5,1},{2,1},{1,1}},16}},{8,11,-1,{{{8,3},{8,2},{7,2},{7,1},{6,1},{6,0}},{{4,4},{5,4},{5,3},{6,3},{6,2},{7,2}},5}},{8,12,-1,{{{8,3},{8,2},{7,2}},{{1,4},{2,4},{2,3}},13}},{8,13,1,{{{8,3},{7,3},{7,4},{4,4},{1,4}},{{1,3},{2,3},{2,2},{5,2},{7,2}},5}},{8,14,1,{{{8,3},{7,3},{7,4},{4,4}},{{2,3},{2,2},{1,2},{1,1},{1,0}},1}},{8,15,-1,{{{8,3},{8,2},{7,2},{7,1}},{{2,2},{2,3},{3,3},{3,4}},11}},{8,16,-1,{{{8,3},{8,2},{7,2},{7,1},{6,1}},{{1,2},{2,2},{2,1},{3,1},{3,0}},1}},{8,17,-1,{{{8,3},{8,2},{7,2},{7,1},{6,1},{6,0}},{{1,1},{1,2},{2,2},{2,3},{3,3},{3,4}},11}},{8,18,-1,{{{8,3},{8,2},{7,2}},{{0,1},{1,1},{1,0}},1}},{9,1,1,{{{7,3},{7,4},{4,4}},{{0,0},{1,0},{1,1}},16}},{9,1,-1,{{{7,3},{8,3},{8,2},{7,2}},{{0,0},{0,1},{1,1},{1,0}},1}},{9,2,1,{{{7,3},{7,4},{4,4},{1,4}},{{3,0},{4,0},{4,3},{4,4}},10}},{9,2,-1,{{{7,3},{8,3},{8,2},{7,2},{7,1},{6,1},{6,0},{3,0}},{{3,0},{2,0},{2,1},{3,1},{3,2},{4,2},{4,3},{7,3}},8}},{9,3,1,{{{7,3},{7,4},{4,4},{1,4}},{{6,0},{6,1},{3,1},{1,1}},16}},{9,3,-1,{{{7,3},{8,3},{8,2},{7,2}},{{6,0},{5,0},{5,1},{6,1}},3}},{9,4,1,{{{7,3},{7,4},{4,4}},{{6,1},{7,1},{7,2},{7,3}},8}},{9,5,1,{{{7,3},{7,4},{4,4},{1,4}},{{7,1},{7,2},{4,2},{2,2}},14}},{9,5,-1,{{{7,3},{8,3},{8,2},{7,2}},{{7,1},{6,1},{6,2},{7,2}},5}},{9,7,1,{{{7,3},{7,4},{4,4},{1,4}},{{8,2},{8,3},{7,3},{5,3},{2,3}},13}},{9,7,-1,{{{7,3},{8,3},{8,2}},{{8,2},{7,2},{7,3}},8}},{9,8,1,{{{7,3},{7,4},{4,4}},{{8,3},{7,3},{7,2}},5}},{9,10,-1,{{{7,3},{8,3},{8,2},{7,2}},{{7,4},{7,3},{6,3},{6,4}},10}},{9,11,-1,{{{7,3},{8,3},{8,2},{7,2},{7,1},{6,1},{6,0},{3,0}},{{4,4},{5,4},{5,3},{4,3},{4,2},{3,2},{3,1},{1,1}},16}},{9,12,1,{{{7,3},{7,4},{4,4},{1,4}},{{1,4},{1,3},{2,3},{4,3},{7,3}},8}},{9,12,-1,{{{7,3},{8,3},{8,2}},{{1,4},{2,4},{2,3}},13}},{9,13,1,{{{7,3},{7,4},{4,4}},{{1,3},{2,3},{2,4}},11}},{9,13,-1,{{{7,3},{8,3},{8,2},{7,2}},{{1,3},{1,4},{2,4},{2,3}},13}},{9,14,1,{{{7,3},{7,4},{4,4},{1,4}},{{2,3},{2,2},{5,2},{7,2}},5}},{9,15,1,{{{7,3},{7,4},{4,4}},{{2,2},{1,2},{1,1},{1,0}},1}},{9,15,-1,{{{7,3},{8,3},{8,2},{7,2},{7,1},{6,1},{6,0},{3,0}},{{2,2},{2,3},{3,3},{3,2},{4,2},{4,1},{5,1},{5,0}},2}},{9,16,1,{{{7,3},{7,4},{4,4},{1,4}},{{1,2},{1,1},{4,1},{6,1}},3}},{9,16,-1,{{{7,3},{8,3},{8,2},{7,2}},{{1,2},{2,2},{2,1},{1,1}},16}},{9,17,-1,{{{7,3},{8,3},{8,2},{7,2},{7,1},{6,1}},{{1,1},{1,2},{2,2},{2,1},{3,1},{3,0}},1}},{9,18,1,{{{7,3},{7,4},{4,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}},{{0,1},{0,0},{3,0},{6,0},{6,1},{5,1},{5,2},{6,2},{6,3},{7,3}},8}},{9,18,-1,{{{7,3},{8,3},{8,2}},{{0,1},{1,1},{1,0}},1}},{10,1,1,{{{7,4},{4,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}},{{0,0},{3,0},{6,0},{6,1},{5,1},{5,2},{6,2},{6,3},{7,3}},8}},{10,3,1,{{{7,4},{4,4},{1,4}},{{6,0},{6,1},{6,3},{6,4}},10}},{10,5,1,{{{7,4},{4,4}},{{7,1},{7,2},{7,3}},8}},{10,8,1,{{{7,4},{4,4},{1,4}},{{8,3},{7,3},{5,3},{2,3}},13}},{10,13,1,{{{7,4},{4,4},{1,4}},{{1,3},{2,3},{4,3},{7,3}},8}},{10,14,1,{{{7,4},{4,4}},{{2,3},{2,2},{2,0}},1}},{10,16,1,{{{7,4},{4,4}},{{1,2},{1,1},{1,0}},1}},{10,16,-1,{{{7,4},{7,3},{8,3},{8,2},{7,2},{7,1},{6,1},{6,0},{3,0}},{{1,2},{2,2},{2,3},{3,3},{3,2},{4,2},{4,1},{5,1},{5,0}},2}},{10,18,-1,{{{7,4},{7,3},{8,3},{8,2},{7,2},{7,1},{6,1}},{{0,1},{1,1},{1,2},{2,2},{2,1},{3,1},{3,0}},1}},{11,1,1,{{{4,4},{1,4},{1,3},{2,3},{2,2}},{{0,0},{3,0},{3,1},{2,1},{2,2}},14}},{11,2,1,{{{4,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}},{{3,0},{6,0},{6,1},{5,1},{5,2},{6,2},{6,3},{7,3}},8}},{11,3,1,{{{4,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}},{{6,0},{6,1},{6,3},{5,3},{5,2},{4,2},{4,3},{3,3},{3,4}},11}},{11,3,-1,{{{4,4},{7,4},{7,3},{8,3},{8,2}},{{6,0},{3,0},{3,1},{2,1},{2,2}},14}},{11,5,1,{{{4,4},{1,4}},{{7,1},{7,2},{7,3}},8}},{11,5,-1,{{{4,4},{7,4},{7,3},{8,3},{8,2},{7,2},{7,1}},{{7,1},{6,1},{4,1},{4,2},{3,2},{3,3},{4,3},{4,4}},10}},{11,7,-1,{{{4,4},{7,4},{7,3},{8,3},{8,2}},{{8,2},{7,2},{5,2},{5,3},{4,3},{4,4}},10}},{11,8,1,{{{4,4},{1,4},{1,3},{2,3},{2,2}},{{8,3},{7,3},{5,3},{5,2},{6,2},{6,1}},3}},{11,10,1,{{{4,4},{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1},{0,0}},{{7,4},{4,4},{4,3},{5,3},{5,2},{4,2},{4,1},{3,1},{3,0}},1}},{11,10,-1,{{{4,4},{7,4}},{{7,4},{7,3},{7,2}},5}},{11,12,-1,{{{4,4},{7,4},{7,3},{8,3},{8,2},{7,2},{7,1},{6,1},{6,0}},{{1,4},{4,4},{4,3},{5,3},{5,2},{4,2},{4,1},{3,1},{3,0}},1}},{11,13,1,{{{4,4},{1,4},{1,3}},{{1,3},{2,3},{4,3},{4,4}},10}},{11,14,1,{{{4,4},{1,4}},{{2,3},{2,2},{2,0}},1}},{11,15,-1,{{{4,4},{7,4}},{{2,2},{2,3},{2,4}},11}},{11,16,1,{{{4,4},{1,4}},{{1,2},{1,1},{1,0}},1}},{11,16,-1,{{{4,4},{7,4},{7,3},{8,3},{8,2}},{{1,2},{2,2},{4,2},{4,1},{5,1},{5,0}},2}},{11,18,-1,{{{4,4},{7,4},{7,3}},{{0,1},{1,1},{3,1},{3,0}},1}},{12,1,1,{{{1,4},{1,3},{2,3}},{{0,0},{1,0},{1,1}},16}},{12,2,1,{{{1,4},{1,3},{2,3},{2,2},{1,2}},{{3,0},{4,0},{4,1},{5,1},{5,0}},2}},{12,3,1,{{{1,4},{1,3},{2,3},{2,2},{1,2},{1,1},{0,1}},{{6,0},{6,1},{5,1},{5,2},{6,2},{6,3},{7,3}},8}},{12,5,1,{{{1,4},{1,3},{2,3},{2,2},{1,2}},{{7,1},{7,2},{6,2},{6,3},{7,3}},8}},{12,5,-1,{{{1,4},{4,4},{7,4}},{{7,1},{6,1},{4,1},{1,1}},16}},{12,7,-1,{{{1,4},{4,4},{7,4}},{{8,2},{7,2},{5,2},{2,2}},14}},{12,8,1,{{{1,4},{1,3},{2,3}},{{8,3},{7,3},{7,2}},5}},{12,10,1,{{{1,4},{1,3},{2,3},{2,2},{1,2}},{{7,4},{6,4},{6,3},{5,3},{5,4}},10}},{12,10,-1,{{{1,4},{4,4}},{{7,4},{7,3},{7,2}},5}},{12,11,1,{{{1,4},{1,3},{2,3},{2,2}},{{4,4},{3,4},{3,3},{2,3}},13}},{12,15,-1,{{{1,4},{4,4}},{{2,2},{2,3},{2,4}},11}},{12,16,1,{{{1,4},{1,3},{2,3},{2,2}},{{1,2},{1,1},{2,1},{2,0}},1}},{12,16,-1,{{{1,4},{4,4},{7,4}},{{1,2},{2,2},{4,2},{7,2}},5}},{12,18,-1,{{{1,4},{4,4},{7,4}},{{0,1},{1,1},{3,1},{6,1}},3}},{13,1,-1,{{{1,3},{1,4},{4,4},{7,4}},{{0,0},{0,1},{1,1},{3,1},{6,1}},3}},{13,2,-1,{{{1,3},{1,4},{4,4}},{{3,0},{2,0},{2,2}},14}},{13,3,-1,{{{1,3},{1,4},{4,4},{7,4}},{{6,0},{5,0},{5,3},{5,4}},10}},{13,5,-1,{{{1,3},{1,4},{4,4}},{{7,1},{6,1},{6,4}},10}},{13,6,-1,{{{1,3},{1,4},{4,4},{7,4}},{{7,2},{7,1},{6,1},{4,1},{1,1}},16}},{13,7,-1,{{{1,3},{1,4},{4,4}},{{8,2},{7,2},{7,3}},8}},{13,8,-1,{{{1,3},{1,4},{4,4},{7,4}},{{8,3},{8,2},{7,2},{5,2},{2,2}},14}},{13,10,-1,{{{1,3},{1,4},{4,4},{7,4}},{{7,4},{7,3},{4,3},{2,3}},13}},{13,15,-1,{{{1,3},{1,4},{4,4},{7,4}},{{2,2},{2,3},{5,3},{7,3}},8}},{13,16,-1,{{{1,3},{1,4},{4,4}},{{1,2},{2,2},{2,0}},1}},{13,17,-1,{{{1,3},{1,4},{4,4},{7,4}},{{1,1},{1,2},{2,2},{4,2},{7,2}},5}},{13,18,-1,{{{1,3},{1,4},{4,4}},{{0,1},{1,1},{1,0}},1}},{14,1,-1,{{{2,3},{1,3},{1,4},{4,4}},{{0,0},{0,1},{1,1},{1,0}},1}},{14,2,-1,{{{2,3},{1,3},{1,4},{4,4},{7,4}},{{3,0},{2,0},{2,1},{5,1},{6,1}},3}},{14,3,1,{{{2,3},{2,2},{1,2},{1,1},{0,1},{0,0},{3,0},{6,0}},{{6,0},{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{5,3},{2,3}},13}},{14,3,-1,{{{2,3},{1,3},{1,4},{4,4}},{{6,0},{5,0},{5,1},{6,1}},3}},{14,4,-1,{{{2,3},{1,3},{1,4},{4,4},{7,4}},{{6,1},{6,0},{5,0},{5,3},{5,4}},10}},{14,5,-1,{{{2,3},{1,3},{1,4},{4,4}},{{7,1},{6,1},{6,2},{7,2}},5}},{14,6,-1,{{{2,3},{1,3},{1,4},{4,4}},{{7,2},{7,1},{6,1},{6,4}},10}},{14,7,-1,{{{2,3},{1,3},{1,4}},{{8,2},{7,2},{7,3}},8}},{14,8,-1,{{{2,3},{1,3},{1,4},{4,4}},{{8,3},{8,2},{7,2},{7,3}},8}},{14,9,-1,{{{2,3},{1,3},{1,4},{4,4},{7,4}},{{7,3},{8,3},{8,2},{7,2},{5,2},{2,2}},14}},{14,10,-1,{{{2,3},{1,3},{1,4},{4,4}},{{7,4},{7,3},{6,3},{6,4}},10}},{14,11,-1,{{{2,3},{1,3},{1,4},{4,4}},{{4,4},{5,4},{5,3},{2,3}},13}},{14,12,-1,{{{2,3},{1,3},{1,4}},{{1,4},{2,4},{2,3}},13}},{14,13,1,{{{2,3},{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{1,3},{2,3},{2,2},{3,2},{3,1},{4,1},{4,4}},10}},{14,15,-1,{{{2,3},{1,3},{1,4},{4,4}},{{2,2},{2,3},{3,3},{3,0}},1}},{14,16,-1,{{{2,3},{1,3},{1,4},{4,4}},{{1,2},{2,2},{2,1},{1,1}},16}},{14,17,-1,{{{2,3},{1,3},{1,4},{4,4}},{{1,1},{1,2},{2,2},{2,0}},1}},{14,18,-1,{{{2,3},{1,3},{1,4}},{{0,1},{1,1},{1,0}},1}},{15,1,1,{{{2,2},{1,2},{1,1}},{{0,0},{1,0},{1,1}},16}},{15,2,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{3,0},{4,0},{4,1},{5,1},{5,2},{2,2}},14}},{15,3,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{6,0},{6,1},{5,1},{5,2},{4,2},{4,0}},2}},{15,4,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0},{6,0}},{{6,1},{7,1},{7,2},{8,2},{8,3},{7,3},{5,3},{2,3}},13}},{15,5,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{7,1},{7,2},{6,2},{6,3},{5,3},{5,0}},2}},{15,5,-1,{{{2,2},{2,3},{1,3},{1,4},{4,4},{7,4}},{{7,1},{6,1},{6,0},{5,0},{5,3},{5,4}},10}},{15,7,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{8,2},{8,3},{7,3},{7,4},{6,4},{6,1}},3}},{15,7,-1,{{{2,2},{2,3},{1,3},{1,4},{4,4}},{{8,2},{7,2},{7,1},{6,1},{6,4}},10}},{15,8,1,{{{2,2},{1,2},{1,1}},{{8,3},{7,3},{7,2}},5}},{15,10,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{7,4},{6,4},{6,3},{5,3},{5,2},{7,2}},5}},{15,10,-1,{{{2,2},{2,3},{1,3},{1,4},{4,4},{7,4}},{{7,4},{7,3},{8,3},{8,2},{7,2},{5,2},{2,2}},14}},{15,11,1,{{{2,2},{1,2},{1,1},{0,1}},{{4,4},{3,4},{3,3},{2,3}},13}},{15,12,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{1,4},{1,3},{2,3},{2,2},{3,2},{3,4}},11}},{15,13,1,{{{2,2},{1,2},{1,1}},{{1,3},{2,3},{2,4}},11}},{15,14,1,{{{2,2},{1,2},{1,1},{0,1},{0,0},{3,0}},{{2,3},{2,2},{3,2},{3,1},{4,1},{4,4}},10}},{15,16,-1,{{{2,2},{2,3},{1,3},{1,4},{4,4}},{{1,2},{2,2},{2,3},{3,3},{3,0}},1}},{15,18,-1,{{{2,2},{2,3},{1,3},{1,4},{4,4}},{{0,1},{1,1},{1,2},{2,2},{2,0}},1}},{16,3,1,{{{1,2},{1,1},{0,1},{0,0},{3,0},{6,0}},{{6,0},{6,1},{7,1},{7,2},{4,2},{2,2}},14}},{16,5,1,{{{1,2},{1,1},{0,1},{0,0},{3,0},{6,0}},{{7,1},{7,2},{8,2},{8,3},{7,3},{5,3},{2,3}},13}},{16,8,1,{{{1,2},{1,1},{0,1},{0,0},{3,0}},{{8,3},{7,3},{7,4},{6,4},{6,1}},3}},{16,13,1,{{{1,2},{1,1},{0,1},{0,0},{3,0}},{{1,3},{2,3},{2,2},{3,2},{3,4}},11}},{16,14,1,{{{1,2},{1,1},{0,1},{0,0},{3,0},{6,0}},{{2,3},{2,2},{1,2},{1,1},{4,1},{6,1}},3}},{17,1,1,{{{1,1},{0,1},{0,0}},{{0,0},{1,0},{1,1}},16}},{17,2,1,{{{1,1},{0,1},{0,0},{3,0}},{{3,0},{4,0},{4,1},{1,1}},16}},{17,2,-1,{{{1,1},{1,2},{2,2},{2,3}},{{3,0},{2,0},{2,1},{1,1}},16}},{17,3,1,{{{1,1},{0,1},{0,0},{3,0}},{{6,0},{6,1},{5,1},{5,0}},2}},{17,3,-1,{{{1,1},{1,2},{2,2},{2,3},{1,3}},{{6,0},{5,0},{5,1},{4,1},{4,0}},2}},{17,4,1,{{{1,1},{0,1},{0,0},{3,0},{6,0}},{{6,1},{7,1},{7,2},{4,2},{2,2}},14}},{17,5,1,{{{1,1},{0,1},{0,0},{3,0}},{{7,1},{7,2},{6,2},{6,1}},3}},{17,5,-1,{{{1,1},{1,2},{2,2},{2,3},{1,3},{1,4},{4,4}},{{7,1},{6,1},{6,2},{5,2},{5,1},{4,1},{4,4}},10}},{17,6,1,{{{1,1},{0,1},{0,0},{3,0},{6,0}},{{7,2},{8,2},{8,3},{7,3},{5,3},{2,3}},13}},{17,7,1,{{{1,1},{0,1},{0,0},{3,0}},{{8,2},{8,3},{7,3},{7,2}},5}},{17,7,-1,{{{1,1},{1,2},{2,2}},{{8,2},{7,2},{7,3}},8}},{17,8,1,{{{1,1},{0,1},{0,0}},{{8,3},{7,3},{7,2}},5}},{17,9,1,{{{1,1},{0,1},{0,0},{3,0}},{{7,3},{7,4},{6,4},{6,1}},3}},{17,10,1,{{{1,1},{0,1},{0,0},{3,0}},{{7,4},{6,4},{6,3},{7,3}},8}},{17,10,-1,{{{1,1},{1,2},{2,2},{2,3},{1,3}},{{7,4},{7,3},{6,3},{6,2},{7,2}},5}},{17,11,1,{{{1,1},{0,1},{0,0},{3,0},{6,0}},{{4,4},{3,4},{3,3},{6,3},{7,3}},8}},{17,11,-1,{{{1,1},{1,2},{2,2},{2,3},{1,3}},{{4,4},{5,4},{5,3},{6,3},{6,4}},10}},{17,12,1,{{{1,1},{0,1},{0,0},{3,0}},{{1,4},{1,3},{2,3},{2,4}},11}},{17,12,-1,{{{1,1},{1,2},{2,2}},{{1,4},{2,4},{2,3}},13}},{17,13,1,{{{1,1},{0,1},{0,0}},{{1,3},{2,3},{2,4}},11}},{17,14,1,{{{1,1},{0,1},{0,0},{3,0}},{{2,3},{2,2},{3,2},{3,4}},11}},{17,15,1,{{{1,1},{0,1},{0,0},{3,0},{6,0}},{{2,2},{1,2},{1,1},{4,1},{6,1}},3}},{17,16,1,{{{1,1},{0,1},{0,0},{3,0}},{{1,2},{1,1},{2,1},{2,2}},14}},{17,18,-1,{{{1,1},{1,2},{2,2}},{{0,1},{1,1},{1,0}},1}},{18,3,1,{{{0,1},{0,0},{3,0},{6,0}},{{6,0},{6,1},{3,1},{1,1}},16}},{18,4,1,{{{0,1},{0,0},{3,0}},{{6,1},{7,1},{7,2},{7,3}},8}},{18,5,1,{{{0,1},{0,0},{3,0},{6,0}},{{7,1},{7,2},{4,2},{2,2}},14}},{18,7,1,{{{0,1},{0,0},{3,0},{6,0}},{{8,2},{8,3},{7,3},{5,3},{2,3}},13}},{18,8,1,{{{0,1},{0,0},{3,0}},{{8,3},{7,3},{7,2}},5}},{18,10,1,{{{0,1},{0,0},{3,0}},{{7,4},{6,4},{6,1}},3}},{18,11,1,{{{0,1},{0,0},{3,0},{6,0}},{{4,4},{3,4},{3,1},{3,0}},1}},{18,12,1,{{{0,1},{0,0},{3,0},{6,0}},{{1,4},{1,3},{2,3},{4,3},{7,3}},8}},{18,13,1,{{{0,1},{0,0},{3,0}},{{1,3},{2,3},{2,4}},11}},{18,14,1,{{{0,1},{0,0},{3,0},{6,0}},{{2,3},{2,2},{5,2},{7,2}},5}},{18,15,1,{{{0,1},{0,0},{3,0}},{{2,2},{1,2},{1,1},{1,0}},1}},{18,16,1,{{{0,1},{0,0},{3,0},{6,0}},{{1,2},{1,1},{4,1},{6,1}},3}}}
];


(* ::Subsubsection:: *)
(*move and SGPolygonPoint*)


poly1 = NewPolygon`Private`makeSGPolygon[{{0,0},{5,0},{5,-2},{6,-2},{6,-7},{4,-7},{4,-4},{0,-4}}];


moveTest[ poly_, a_, dir_, step_ ] := Module[ { 
		r = QuietEcho @ NewPolygon`Private`move[ poly[a], dir, step ] 
	},
	If[ r === Null, 
		r, 
		Append[
			(r[[1,1]] /@ {"vertex", "offset", "inside" }) /. Missing[___] -> Null , 
			r[[2]] 
		]
	] 
];


TestCreate[
	moveTest[ poly1, 3, {1, 0}, 1 ],
	{ 4, 0, Null, False }
]


TestCreate[
	moveTest[ poly1, 3, {1, 0}, 2 ],
	Null
]


TestCreate[
	moveTest[ poly1, 8, {1, 0}, 3],
	{ 7, 1, Null, False }
]


TestCreate[
	moveTest[ poly1, 8, {1, 0}, 5],
	{ Null, Null, { 5, -4 } , True }
]


TestCreate[
	moveTest[ poly1, 8, {1, 0}, 7],
	{ 4, 2, Null, True }
]


TestCreate[
	moveTest[ poly1, 2, {0, -1}, 5],
	{ Null, Null, { 5, -5 }, True }
]


TestCreate[
	moveTest[ poly1, 2, {0, -1}, 10],
	{ 5, 1, Null, True }
]


poly1mid = NewPolygon`Private`makeSGPolygon[{{0,0},{5,0},{5,-2},{6,-2},{6,-7},{5,-7},{4,-7},{4,-4},{0,-4},{0,-2}}];


TestCreate[
	moveTest[ poly1mid, 10, {-1, 0}, 1 ],
	Null
]


End[]
