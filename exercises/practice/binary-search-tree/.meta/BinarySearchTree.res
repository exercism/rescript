type rec tree =
  | EmptyTree
  | TreeNode({value: int, left: tree, right: tree})

let rec insert = (tree, newValue) =>
  switch tree {
  | EmptyTree => TreeNode({value: newValue, left: EmptyTree, right: EmptyTree})
  | TreeNode(node) if newValue <= node.value =>
    TreeNode({...node, left: insert(node.left, newValue)})
  | TreeNode(node) => TreeNode({...node, right: insert(node.right, newValue)})
  }

let binarySearchTree = values => values->Array.reduce(EmptyTree, insert)

let rec sortedData = tree =>
  switch tree {
  | EmptyTree => []
  | TreeNode({value, left, right}) =>
    Array.concat(Array.concat(sortedData(left), [value]), sortedData(right))
  }
