open Test
open BinarySearchTree

let equal = (~message=?, a, b) => assertion(~message?, ~operator="equal", (a, b) => a == b, a, b)

test("data is retained", () => {
  equal(
    ~message="data is retained",
    binarySearchTree([4]),
    TreeNode({value: 4, left: EmptyTree, right: EmptyTree}),
  )
})

test("smaller number at left node", () => {
  equal(
    ~message="smaller number at left node",
    binarySearchTree([4, 2]),
    TreeNode({
      value: 4,
      left: TreeNode({value: 2, left: EmptyTree, right: EmptyTree}),
      right: EmptyTree,
    }),
  )
})

test("same number at left node", () => {
  equal(
    ~message="same number at left node",
    binarySearchTree([4, 4]),
    TreeNode({
      value: 4,
      left: TreeNode({value: 4, left: EmptyTree, right: EmptyTree}),
      right: EmptyTree,
    }),
  )
})

test("greater number at right node", () => {
  equal(
    ~message="greater number at right node",
    binarySearchTree([4, 5]),
    TreeNode({
      value: 4,
      left: EmptyTree,
      right: TreeNode({value: 5, left: EmptyTree, right: EmptyTree}),
    }),
  )
})

test("can create complex tree", () => {
  equal(
    ~message="can create complex tree",
    binarySearchTree([4, 2, 6, 1, 3, 5, 7]),
    TreeNode({
      value: 4,
      left: TreeNode({
        value: 2,
        left: TreeNode({value: 1, left: EmptyTree, right: EmptyTree}),
        right: TreeNode({value: 3, left: EmptyTree, right: EmptyTree}),
      }),
      right: TreeNode({
        value: 6,
        left: TreeNode({value: 5, left: EmptyTree, right: EmptyTree}),
        right: TreeNode({value: 7, left: EmptyTree, right: EmptyTree}),
      }),
    }),
  )
})

test("can sort single number", () => {
  equal(~message="can sort single number", binarySearchTree([2])->sortedData, [2])
})

test("can sort if second number is smaller than first", () => {
  equal(
    ~message="can sort if second number is smaller than first",
    binarySearchTree([2, 1])->sortedData,
    [1, 2],
  )
})

test("can sort if second number is same as first", () => {
  equal(
    ~message="can sort if second number is same as first",
    binarySearchTree([2, 2])->sortedData,
    [2, 2],
  )
})

test("can sort if second number is greater than first", () => {
  equal(
    ~message="can sort if second number is greater than first",
    binarySearchTree([2, 3])->sortedData,
    [2, 3],
  )
})

test("can sort complex tree", () => {
  equal(
    ~message="can sort complex tree",
    binarySearchTree([2, 1, 3, 6, 7, 5])->sortedData,
    [1, 2, 3, 5, 6, 7],
  )
})
